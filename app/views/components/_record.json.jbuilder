record = local_assigns.fetch(:record)
build  = local_assigns.fetch(:build) if record.respond_to?(:each)

can = policy(record)
if record.respond_to?(:each)
  json.records do
    json.array! record do |record|
      instance_exec(record, &build)
    end
  end if build.present?

  json.routes do
    json.index polymorphic_path([ record.model ])                     if can.index?
    json.new   polymorphic_path([ :new, record.model_name.singular ]) if can.new?
  end
else
  json.routes do
    json.show    url_for(record)                     if can.show?
    json.edit    polymorphic_path([ :edit, record ]) if can.edit?
    json.destroy url_for(record)                     if can.destroy?
  end
end