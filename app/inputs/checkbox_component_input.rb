class CheckboxComponentInput < SimpleForm::Inputs::BooleanInput
  include ComponentInput

  def initialize(*args)
    super
    options[:label] = false
  end

  def input(wrapper_options = nil)
    make 'CheckboxInput', wrapper_options
  end

  def props(options)
    {
      checked:
        if options.key? :checked
          options[:checked]
        else
          !!object_value
        end
    }
  end
end