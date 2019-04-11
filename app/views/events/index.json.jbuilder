json.partial! 'components/record', record: @events, build: ->(event) {
  json.(event,
    :id,
    :title,
    :kind,
    :description,
    :start_location,
    :end_location,
  )

  json.starts_at event.starts_at.to_i
  json.ends_at   event.ends_at.to_i

  json.user_in_charge do
    next if event.user_in_charge.nil?
    json.(event.user_in_charge,
      :scout_name
    )
    2
    json.partial! 'components/record', record: event.user_in_charge
  end

  json.groups event.groups do |group|
    json.(group,
      :name,
      :abbreviation,
    )

    json.partial! 'components/record', record: group
  end


  json.partial! 'components/record', record: event
}