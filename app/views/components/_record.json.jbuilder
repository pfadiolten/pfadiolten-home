record = local_assigns.fetch(:record)
build  = local_assigns.fetch(:build) { nil }

controller = controller_class(of: record)

can = policy(record)
if record.respond_to?(:each)
  json.records do
    json.array! record do |record|
      json.partial! 'components/record', record: record, build: build
    end
  end if build.present?

  json.links do
    json.index polymorphic_path([ record.model ])                     if action?(:index, controller) && can.index?
    json.new   polymorphic_path([ :new, record.model_name.singular ]) if action?(:new, controller)   && can.new?
  end
else
  if record.persisted?
    json.id record.id if record.respond_to?(:id)
    json.links do
      json.show    url_for(record)                         if action?(:show, controller)    && can.show?
      json.edit    polymorphic_path(record, action: :edit) if action?(:edit, controller)    && can.edit?
      json.destroy url_for(record)                         if action?(:destroy, controller) && can.destroy?
    end
  end

  instance_exec(record, &build) if build.present?
end