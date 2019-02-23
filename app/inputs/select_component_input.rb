class SelectComponentInput < SimpleForm::Inputs::CollectionSelectInput
  include ComponentInput

  def input(wrapper_options)
     make 'SelectInput', wrapper_options
  end

  def props(options)
    label_method, value_method = detect_collection_methods
    {
      options: collection.map do |record|
        name = record.public_send(label_method)
        value = record.public_send(value_method)
        { name: name, value: value }
      end
    }
  end
end