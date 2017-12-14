class FileHandleInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    attribute = I18n.t("activerecord.attributes.#{lookup_model_names.join('.')}.#{attribute_name}", default: attribute_name.to_s.capitalize)
    text = options.delete(:text) || I18n.t('select_image', attribute: attribute)
    template.content_tag(:div, class: 'handles') do
      handles_element = ActiveSupport::SafeBuffer.new
      existing = input_html_options[:multiple].nil? && object.send(attribute_name).file.present?
      handles_element << template.content_tag(:div, class: 'inputs hidden') do
        inputs_element = ActiveSupport::SafeBuffer.new
        inputs_element << @builder.file_field(attribute_name, merge_wrapper_options(merge_wrapper_options(input_html_options, wrapper_options), { class: 'attribute' }))
        inputs_element << content_tag(:input, nil, type: 'checkbox', class: '_destroy', name: "#{object_name}[remove_#{attribute_name}]", id: "#{object_name}_remove_#{attribute_name}")
        inputs_element
      end
      handles_element << template.content_tag(:div, class: 'buttons') do
        buttons_element = ActiveSupport::SafeBuffer.new
        buttons_element << content_tag(:button, text, class: "gap-bottom-2 btn btn-default col-xs-#{existing ? 8 : 12} attribute", type: 'button')
        buttons_element << content_tag(:button, template.fa_icon('times'), class: 'gap-bottom-2 btn btn-danger col-xs-4 _destroy', type: 'button') if existing
        buttons_element
      end
    end
  end
end