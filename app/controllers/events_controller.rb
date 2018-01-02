class EventsController < ApplicationController
  before_action :load_event, except: %i[index new create] + Event.detail_types.map { |detail, _| [ :"new_#{detail}", :"create_#{detail}" ] }.flatten

  enforce_login! except: %i[index show]

  def index
    @events = policy_scope(Event.all)
    authorize @events
  end

  def show
  end

  def new
    authorize Event
  end

  Event.detail_types.each do |detail, type|
    define_method "new_#{detail}" do
      @event = Event.new(detail: type.new, user_in_charge: current_user)
      @event.starts_at = (Date.today.sunday - 1.day).to_datetime + 14.hours
      @event.ends_at   = @event.starts_at + 3.hours
      current_user.groups.each { |group| @event.event_groups.build(group: group) }
      authorize @event, :new?
      render "events/#{detail.to_s.pluralize}/new"
    end

    define_method "create_#{detail}" do
      @event = Event.new(event_params(detail))
      authorize @event
      @event.save
      respond_with @event
    end
  end

protected
  def load_event
    @event = Event.find_by(id: params[:id]) || not_found
    authorize @event
  end

  def event_params(detail)
    
  end
end
