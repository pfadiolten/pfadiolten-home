module ApplicationHelper
  include Has::Title
  include Has::Alerts
  include Has::Calendar

  def model_name
    controller_name.singularize
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

  def destroy_button(options={})
    title        ||= t("#{controller_path.gsub('/', '.')}.destroy.title", default: "")
    confirmation ||= t("#{controller_path.gsub('/', '.')}.destroy.info", default: "")

    modal_id = 'destroyModal'
    options = options.to_options
    action = options.delete(:action) || 'destroy'
    modal = capture do
      render '/shared/modal', id: modal_id, title: title do
        result = ''.html_safe

        result << content_tag('div', class: 'modal-body') do
          confirmation
        end if confirmation.present?

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
      '<i class="fe fe-trash"></i>'.html_safe
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

  def list_any(records, else_say:, &block)
    if records.any?
      records.each(&block)
      return
    elsif else_say.present?
      content_tag('div', class: 'col-12') do
        content_tag('div', class: 'alert alert-info text-center', role: 'alert') do
          else_say
        end
      end
    end
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
