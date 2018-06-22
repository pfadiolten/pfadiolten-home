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
      fa_icon('check', options)
    else
      classes << 'color-failure'
      fa_icon('times', options)
    end
  end

  def destroy_button(confirmation=t("#{controller_path.gsub('/', '.')}.destroy.confirm"), options={})
    options = options.to_options
    action = options.delete(:action) || 'destroy'
    link_to fa_icon('trash'), url_for(action: action), method: 'delete', class: 'btn btn-danger col-12', data: { confirm: confirmation }
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
