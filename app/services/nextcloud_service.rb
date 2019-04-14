class NextcloudService < ApplicationService
  CONN = Faraday.new(url: 'https://cloud.pfadiolten.ch', proxy: ENV['http_proxy'], ssl: { verify: Rails.env.production? }) do |f|
    f.request :url_encoded
    f.headers.merge!(
      'OCS-APIRequest'  => 'true',
      'Content-Type'    => 'application/x-www-form-urlencoded',
      'Accept'          => 'application/json',
      'Accept-Language' => I18n.locale.to_s,
    )

    f.adapter :patron
  end

  def login(username:, password:)
    response = CONN.post('/ocs/v1.php/person/check') do |req|
      req.headers.delete('Authorization')
      req.params.merge!(
        login:    username,
        password: password,
      )
    end
    extract response, allow: [ 102 ] do |_body, code|
      code != 102
    end
  end

private
  def extract(response, errors: {}, allow: [], &block)
    Response.new(response, errors: errors, allow: allow, &block)
  end

  class Response
    def initialize(response, errors:, allow:, &extract)
      @response = response
      @errors   = errors
      @extract  = extract
      @allow    = allow
    end

    def ok?
      @_ok ||= response.success? && (meta_field[:status] != 'failure' || allow.include?(status_code))
    end

    def result
      @_result ||=
        if extract.present?
          extract.(data_field, status_code)
        else
          true
        end
    end

    def error
      @_error ||= begin
        raise(ArgumentError, 'no error, response is successful') if ok?
        if response.success? || (response.status >= 400 && response.status <= 499)
          error_message
        else
          "#{response.status} - #{body[:message]}"
        end
      end
    end

    def body
      @_body ||= JSON.parse(response.body, symbolize_names: true)
    end

    private
    attr_reader :response,
                :errors,
                :extract,
                :allow

    def meta_field
      body.dig(:ocs, :meta)
    end

    def data_field
      body.dig(:ocs, :data)
    end

    def status_code
      meta_field[:statuscode]
    end

    def error_message
      if (error = errors[status_code])
        return I18n.t(error)
      end
      case status_code
      when 100
        'successful'
      when 996
        'server error'
      when 997
        'not authorized'
      when 998
        'not found'
      when 998
        'unknown error'
      else
        "#{status_code} - #{meta_field[:message] || 'failure'}"
      end
    end
  end
end