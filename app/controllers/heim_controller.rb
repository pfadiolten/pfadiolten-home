class HeimController < ApplicationController
  def index
    skip_policy_scope

    uri = URI.parse('https://cloud.pfadiolten.ch/s/wsxse6Hw3HS82mL/download/heim-status.yml')
    response = Net::HTTP.get_response(uri)

    config = YAML.safe_load(response.body)
    today = Date.today

    # Finish Date
    finish_date = parse_date(config['finish_date'])
    days_until_finish_date = (finish_date - today).to_i

    # Next Meetings
    next_meetings = config['next_meetings'].map(&method(:parse_date))
    next_meeting = next_meetings.select { |meeting| meeting >= today }.min

    # Milestones
    milestones = config['milestones'].map do |milestone|
      OpenStruct.new(
        name: milestone['name'],
        date: parse_date(milestone['date']),
        date_label: milestone['date_label'] || milestone['date'],
      )
    end
    milestones = milestones.sort_by { |it| it.date }
    first_milestone, last_milestone = milestones.first, milestones.last
    milestone_span = (last_milestone.date - first_milestone.date).to_f
    get_ratio = ->(date) {
      ratio = milestone_span.zero? ? 0.0 : ((date - first_milestone.date).to_f / milestone_span)
      return 1.0 if ratio > 1.0
      return 0.0 if ratio < 0.0
      ratio
    }
    ratio_of_today = get_ratio.call(today)
    milestones.each do |milestone|
      ratio = get_ratio.call(milestone.date)
      milestone[:ratio] = ratio
      milestone[:past?] = ratio <= ratio_of_today
    end

    @config = OpenStruct.new(
      days_until_finish_date: days_until_finish_date,
      ratio_of_today: ratio_of_today,
      finish_date: finish_date,
      next_meeting: next_meeting,
      next_meetings: next_meetings,
      milestones: milestones,
      funding: OpenStruct.new(
        goal: config['funding']['goal'].to_i,
        parts: config['funding']['parts'].map do |part|
          OpenStruct.new(
            name: part['name'],
            value: part['value'].to_i,
          )
        end,
      ),
      contact: OpenStruct.new(**config['contact'])
    )
  end

private

  def parse_date(value)
    Date.strptime(value, '%d.%m.%Y')
  end
end