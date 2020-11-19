module ApplicationHelper
  include Has::Title
  include Has::Alerts
  include Has::Calendar

  def model_name
    @_model_name =
      controller.class.name
        .split('::')
        .map { |name| name.chomp('Controller').singularize }
        .join('::')
        .constantize
        .model_name
  end

  def iconize(condition, options={})
    classes = options[:class] ||= []
    classes = [ classes ] unless classes.is_a?(Array)

    if condition
      classes << 'color-success'
      content_tag('i', options)
    else
      classes << 'color-failure'
      content_tag('i', options)
    end
  end

  def submit_buttons_for(f)
    make_submit_button = lambda do |col:|
      content_tag('div', class: "col-#{col}") do
        f.submit class: 'btn btn-primary btn-block'
      end
    end

    content_tag('div', class: 'row') do
      if f.object.persisted? && policy(f.object).destroy?
        make_submit_button.(col: 8) << content_tag('div', class: 'col-4', &method(:destroy_button))
      else
        make_submit_button.(col: 12)
      end
    end
  end

  def destroy_button(options={})
    title        ||= t("#{controller_path.gsub('/', '.')}.destroy.title", default: "")
    confirmation ||= t("#{controller_path.gsub('/', '.')}.destroy.info", default: t('controls.destroy.title'))

    modal_id = 'destroyModal'
    options = options.to_options
    action = options.delete(:action) || 'destroy'
    modal = capture do
      render '/shared/modal', id: modal_id, title: title do
        result = ''.html_safe

        result << content_tag('div', class: 'modal-body') do
          confirmation
        end

        result << content_tag('div', class: 'modal-footer') do
          link_to(url_for(action: action), method: 'delete', class: 'btn btn-danger') do
            t('modal.confirm')
          end <<
          content_tag('button', class: 'btn btn-primary', data: { dismiss: 'modal' }) do
            t('modal.abort')
          end
        end
        result
      end
    end
    content_tag('button', class: 'btn btn-danger col-12', type: 'button', data: { toggle: 'modal', target: "##{modal_id}" }) do
      icons.destroy
    end << modal
  end

  def info(message)
    content_tag('div', message, class: 'alert alert-info text-center')
  end

  def calendar_types
    @calendar_types ||= OpenStruct.new(
      month: 'month',
      week:  'week',
      day:   'day'
    )
  end

  def controller_asset
    "views/#{controller_path}"
  end

  def controller_js?
    exists_js?(controller_asset)
  end

  def controller_css?
    exists_css?(controller_asset)
  end

  def disable_nav!
    content_for(:disable_nav, true)
  end

  def nav_disabled?
    return false unless content_for?(:disable_nav)
    content_for(:disable_nav)
  end

  def list_any(records, else_say:, alert_options: {}, all: false, &block)
    if records.any?
      if all
        block.(records)
      else
        records.each(&block)
      end

      # dont't return data, may end up in template
      return
    elsif else_say.present?
      options = { class: 'alert alert-info text-center', role: 'alert'}.with_indifferent_access
      alert_options.each_pair do |k, v|
        existing_v = options[k]
        options[k] = v and return if existing_v.nil?

        case v
        when String
          options[k] = "#{v} #{existing_v}"
        when Hash
          options[k] = v.merge(v)
        when Array
          options[k] = v + existing_v
        else
          options[k] = v
        end
      end

      content_tag('div', class: 'col-12') do
        content_tag('div', options) do
          else_say
        end
      end
    end
  end

  def image_src
    @_image_src || image_path('logos/pfadi_olten-text.svg')
  end

  def image_src=(link)
    @_image_src = link
  end

  def icons
    @_icons ||= ApplicationHelper::Icons.new(method(:icon))
  end

  def components
    @_components ||= ApplicationHelper::Components.new(view: self)
  end

  def build(*fields, &block)
    builder = ApplicationHelper::Builder.new(self, *fields)
    block.(builder)
    builder
  end

  def variant_path(variant)
    Rails.application.routes.url_helpers.rails_representation_url(variant, only_path: true)
  end

private
  def exists_js?(path)
    %w[ .coffee .coffee.erb .js .js.erb .erb ].inject(false) do |found, ext|
      found || asset_exists?('javascripts', "#{path}#{ext}")
    end
  end

  def exists_css?(path)
    %w[ .scss .scss.erb .css .css.erb .sass .sass.erb .erb ].inject(false) do |found, ext|
      found || asset_exists?('stylesheets', "#{path}#{ext}")
    end
  end

  def asset_exists?(subdirectory, filename)
    File.exists?(File.join(Rails.root, 'app', 'assets', subdirectory, filename))
  end
end
