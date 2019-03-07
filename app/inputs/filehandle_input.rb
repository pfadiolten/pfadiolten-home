class FilehandleInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    attribute = I18n.t("activerecord.attributes.#{object.model_name.i18n_key}.#{attribute_name}", default: attribute_name.to_s.capitalize)
    text = options.delete(:text) || I18n.t('select_image', attribute: attribute)

    template.content_tag(:div, class: 'handles') do
      handles_element = ActiveSupport::SafeBuffer.new
      existing = input_html_options[:multiple].nil? && object.send(attribute_name).attached?
      handles_element << template.content_tag(:div, class: 'inputs d-none') do
        inputs_element = ActiveSupport::SafeBuffer.new
        inputs_element << @builder.file_field(attribute_name, merge_wrapper_options(merge_wrapper_options(input_html_options, wrapper_options), { class: 'attribute' }))

        if object.persisted?
          inputs_element << content_tag('input', object.id, type: 'hidden', name: "#{object_name}[id]", id: "#{object_name}_id")

          destroy_checkbox_name = "#{object_name}[_destroy]"
          destroy_checkbox_id   = "#{object_name}__destroy"
          inputs_element << content_tag(:input, nil, type: 'checkbox', class: '_destroy', name: destroy_checkbox_name, id: destroy_checkbox_id)
        end
        inputs_element
      end
      handles_element << template.content_tag(:div, class: 'buttons mb-6') do
        buttons_element = ActiveSupport::SafeBuffer.new
        buttons_element << content_tag(:button, text, class: "btn btn-primary col-#{existing ? 8 : 12} attribute", type: 'button')
        buttons_element << content_tag(:button, template.icons.close, class: 'btn btn-danger col-4 _destroy', type: 'button') if existing
        buttons_element
      end
    end
  end

  def label(_)
    false
  end
end