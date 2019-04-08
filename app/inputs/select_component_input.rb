class SelectComponentInput < SimpleForm::Inputs::CollectionSelectInput
  include ComponentInput

  def input(wrapper_options)
     make 'SelectInput', wrapper_options
  end

  def props(options)
    label_method, value_method = detect_collection_methods
    {
      options: collection.map do |record|
        name  = execute_method_on(record, label_method)
        value = execute_method_on(record, value_method)
        { name: name, value: value }
      end
    }
  end

private
  def execute_method_on(value, method)
    if method.is_a?(Proc)
      method.(value)
    else
      value.public_send(method)
    end
  end
end