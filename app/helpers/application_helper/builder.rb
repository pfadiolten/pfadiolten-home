class ApplicationHelper::Builder
  def initialize(view, *fields)
    @view = view
    fields.each(&method(:define_field))
  end

private
  attr_reader :view

  def define_field(field)
    variable =  "@_#{field}"
    define_singleton_method field do |&block|
      if block.present?
        value = view.capture(&block)
        instance_variable_set(variable, value)
      else
        instance_variable_get(variable)
      end
    end
  end
end