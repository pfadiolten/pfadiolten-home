json.array! @events do |event|
  json.(event,
    :title,
    :description,
    :starts_at,
    :start_location,
    :ends_at,
    :end_location,
  )

  json.url path_for(event, url: true)

  json.user_in_charge do
    json.(event.user_in_charge,

    )
  end

  json.groups event.groups do |group|
    json.(group,
      :name,
    )
  end
end