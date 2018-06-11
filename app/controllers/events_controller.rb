class EventsController < ApplicationController
  before_action :load_event, except: %i[index new create] + Event.detail_types.map { |detail, _| [ :"new_#{detail}", :"create_#{detail}" ] }.flatten

  enforce_login! except: %i[index show]

  def index
    @events = policy_scope(Event.all)
    authorize @events
  end

  def show
    authorize @event
  end

  def new
    authorize Event
  end

  Event.detail_types.each do |detail, type|
    new_template = "events/#{detail.to_s.pluralize}/new"

    define_method "new_#{detail}" do
      @event = Event.new(detail: type.new, user_in_charge: current_user)
      @event.starts_at = (Date.today.sunday.in_time_zone - 1.day).to_datetime + 14.hours
      @event.ends_at   = @event.starts_at + 3.hours
      current_user.groups.each { |group| @event.event_groups.build(group: group) }
      authorize @event, :new?
      render new_template
    end

    define_method "create_#{detail}" do
      @event = Event.new(event_params(detail))
      @event.detail ||= type.new
      authorize @event, :create?
      @event.save
      respond_with @event, action: "new_#{detail}", render: new_template, location: ->{ event_path(@event) }
    end

    define_method "edit_#{detail}" do
      authorize @event, :edit?
      render 'events/edit'
    end

    define_method "update_#{detail}" do
      authorize @event, :update?

      new_params = event_params(detail)
      group_events = new_params[:event_groups_attributes] ||= []
      @event.event_groups.each do |group_event|
        if (group_index = group_events.find_index { |it| it[:group_id].to_i == group_event.group_id })
          group_events.delete_at(group_index)
        else
          group_events << { id: group_event.id, _destroy: true }
        end
      end

      @event.update(new_params)
      respond_with @event, action: "edit_#{detail}", render: 'edit', location: ->{ event_path(@event) }
    end
  end

  def destroy
    authorize @event
    @event.destroy
    respond_with @event, action: "edit_#{@event.detail.handle}", location: ->{ root_path }
  end

protected
  def load_event
    @event = Event.find_by(id: params[:id]) || not_found
  end

private
  def event_params(detail)
    params.require(:event).permit(
      :name,
      :starts_at,
      :start_location,
      :ends_at,
      :end_location,
      :user_in_charge_id,
      :is_hidden,
      :is_private,
      :display_days_amount,
      event_groups_attributes: [
        :group_id,
      ],
      detail_attributes: [

      ],
    )
  end
end
