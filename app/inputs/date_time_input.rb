class DateTimeInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    html_options = input_html_options
    date_type = html_options.delete(:date_type) || 'datetime'

    template.content_tag(:div, class: "input-group date #{date_type}-picker") do
      template.concat @builder.text_field(attribute_name, merge_wrapper_options(html_options, wrapper_options))
      template.concat content_tag('span', tag('span', class: 'fa fa-calendar', aria: { hidden: true }), class: 'input-group-addon')
    end
  end

  def input_html_options
    { value: default_value }.merge(super)
  end

  def default_value
    object.send(attribute_name).to_time.strftime('%d.%m.%Y - %H:%M') if object.send(attribute_name).present?
  end
end