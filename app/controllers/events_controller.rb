class EventsController < ApplicationController
  def index
    day = selected_day
    @events = policy_scope Event.of_year(day.year).of_month(day.month)
  end

  def new
    starts_at = (Date.today.in_time_zone.to_date.sunday - 1.day).to_time + 14.hours
    @event = authorize Event.new(
      starts_at:      starts_at,
      ends_at:        starts_at + 3.hours,
      user_in_charge: current_user,
    )
  end

  def create
  end

private
  def selected_day
    @_first_day_of_month ||= begin
      today = Date.today
      year  = params[:year]&.to_i  || today.year
      month = params[:month]&.to_i || today.month
      day   = params[:day]&.to_i   || today.day

      Date.new(year, month, day).at_beginning_of_month
    end
  end

  helper_method :selected_day
end
