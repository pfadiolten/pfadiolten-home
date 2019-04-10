json.data do
  json.array! @events do |event|
    json.(event,
      :id,
      :title,
      :description,
      :starts_at,
      :start_location,
      :ends_at,
      :end_location,
    )

    json.url url_for(event)

    json.user_in_charge do
      next if event.user_in_charge.nil?
      json.(event.user_in_charge,
        :scout_name
      )
    end

    json.groups event.groups do |group|
      json.(group,
        :name,
      )
    end
  end
end

json.routes do
  json.index events_path     if policy(@events).index?
  json.new   new_event_path if policy(@events).new?
end