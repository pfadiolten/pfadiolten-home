class EventsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        skip_policy_scope
        authorize Event
      end
      format.json do
        day = selected_day
        @events = policy_scope Event.of_year(day.year).of_month(day.month).of_day(day.day).order_by_date
        render layout: false
      end
    end
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
    @event = authorize Event.new(event_params)
    @event.save
    respond_with @event, location: form_location
  end

  def edit
    @event = authorize find_event
  end

  def update
    @event = authorize find_event
    @event.update(event_params)
    respond_with @event, location: form_location
  end

  def destroy
    @event = authorize find_event
    @event.destroy
    respond_with @event, action: 'edit', location: form_location
  end

private
  def event_params
    params.require(:event).permit(
      :title,
      :description,
      :kind,
      :starts_at,
      :start_location,
      :ends_at,
      :end_location,
      :user_in_charge_id,
      :group_ids,
    )
  end

  def selected_day
    @_selected_day ||= begin
      today = Date.today
      year  = params[:year]&.to_i  || today.year
      month = params[:month]&.to_i || today.month
      day   = params[:day]&.to_i   || today.day

      Date.new(year, month, day)
    end
  end

  def find_event
    id = params.fetch(:title).split('@').last
    Event.find_by(id: id) || not_found
  end

  def form_location
    ->{ events_path(date: @event.starts_at.strftime('%Y.%-m.%-d')) }
  end

  helper_method :selected_day
end
