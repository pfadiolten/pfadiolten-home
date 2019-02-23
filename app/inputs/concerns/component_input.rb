module ComponentInput
  extend ActiveSupport::Concern

  def make(component_name, wrapper_options)
    options = merge_wrapper_options(input_html_options, wrapper_options)
    props = {
      id:    "#{object_name_id}_#{attribute_name}",
      name:  "#{object_name}[#{attribute_name}]",
      label: label_text,
      **options,
      **props(options),
    }

    props[:value] = value if value.present?

    template.components.make component_name, props
  end

  def props(options)
    {}
  end

  def value
    nil
  end

  def object_name_id
    @_object_name_id ||= object_name.to_s.gsub(/\]?\[/, '_')
  end

  def object_value
    object.public_send(attribute_name)
  end
end