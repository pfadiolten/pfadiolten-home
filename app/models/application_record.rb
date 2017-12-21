class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_validation :clear_blank_values

  def clear_blank_values
    attributes.each_pair do |attribute, value|
      write_attribute(attribute, nil) if value.blank?
    end
  end

  class << self
    def default_for(attribute, is: nil, &block)
      raise 'no default supplier given' if is.nil? && block.nil?
      block ||= ->{ is }
      defaultation = proc do
        value = send(attribute)
        next if value.present?
        send("#{attribute}=", block.())
      end
      before_validation &defaultation
      before_save &defaultation
    end

    def sanitize_html_of(*attributes)
      before_validation do
        attributes.each do |attribute|
          send("#{attribute}=", Sanitize.fragment(send("#{attribute}"), Sanitize::Config::RELAXED))
        end
      end
    end
  end
end
