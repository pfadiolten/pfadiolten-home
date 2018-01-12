module ApplicationHelper
  include Has::Title
  include Has::Alerts
  include Has::Navigation

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

  def destroy_button(confirmation=t("#{controller_name}.destroy.confirm"), options={})
    options = options.to_options
    action = options.delete(:action) || 'destroy'
    link_to fa_icon('trash'), url_for(action: action), method: 'delete', class: 'btn btn-danger col-xs-12', data: { confirm: confirmation }
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
end
