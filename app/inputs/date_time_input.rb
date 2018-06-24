class DateTimeInput < SimpleForm::Inputs::Base
  delegate :content_tag, :concat, to: :template

  def input(wrapper_options)
    html_options = input_html_options
    date_type    = html_options.delete(:date_type) || 'datetime'
    html_options = merge_wrapper_options(html_options, wrapper_options)



    content_tag(:div, class: "input-group date #{date_type}-picker", data: { 'target-input': 'nearest' }) do
      concat @builder.text_field(attribute_name, html_options)
      concat(content_tag('div', aria: { hidden: true }, class: 'input-group-append', data: { toggle: 'datetimepicker' }) do
        content_tag('div', class: 'input-group-text') do
          content_tag('i', nil, class: 'fe fe-calendar')
        end
      end)
    end
  end

  def input_html_options
    opts = { **super, value: default_value }
    classes = opts[:class] = Array(opts[:class])
    classes << 'datetimepicker-input'
    opts
  end

  def default_value
    object.send(attribute_name).to_time.strftime('%d.%m.%Y - %H:%M') if object.send(attribute_name).present?
  end
end