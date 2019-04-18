class DateTimeComponentInput < SimpleForm::Inputs::Base
  include ComponentInput

  def input(wrapper_options = nil)
    make 'UI/Input/DateTime', wrapper_options
  end

  def props(options)
    # :date or :datetime
    date_type = (options.delete(:date_type) || :datetime).to_sym
    {
      noTime: date_type == :date,
    }
  end

  def value
    value = object.public_send(attribute_name)
    value.to_time.strftime('%d.%m.%Y - %H:%M') if value.present?
  end
end