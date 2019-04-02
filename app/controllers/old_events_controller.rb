class OldEventsController < ApplicationController
  before_action :load_old_event, except: %i[index new create] + OldEvent.detail_types.map { |detail, _| [ :"new_#{detail}", :"create_#{detail}" ] }.flatten

  enforce_login! except: %i[index show]

  def new
    authorize OldEvent
  end

  OldEvent.detail_types.each do |detail, type|
    new_template = "old_events/#{detail.to_s.pluralize}/new"

    define_method "new_#{detail}" do
      @old_event = OldEvent.new(detail: type.new, user_in_charge: current_user)
      @old_event.starts_at = (Date.today.sunday.in_time_zone - 1.day).to_datetime + 14.hours
      @old_event.ends_at   = @old_event.starts_at + 3.hours

      if (groups = params[:groups])
        groups.each do |abbr|
          group = Group.with_abbreviation(abbr).first || raise("group with abbreviation \"#{group}\" not found")
          @old_event.old_event_groups.build(group: group)
        end
      else
        current_user.groups.each do |group|
          @old_event.old_event_groups.build(group: group)
        end
      end
      authorize @old_event, :new?
      render new_template
    end

    define_method "create_#{detail}" do
      @old_event = OldEvent.new(old_event_params(detail))
      @old_event.detail ||= type.new
      authorize @old_event, :create?
      @old_event.save
      respond_with @old_event, action: "new_#{detail}", render: new_template, location: ->{ root_path }
    end

    define_method "edit_#{detail}" do
      authorize @old_event, :edit?
      render 'old_events/edit'
    end

    define_method "update_#{detail}" do
      authorize @old_event, :update?

      new_params = old_event_params(detail)
      group_old_events = new_params[:old_event_groups_attributes] ||= []
      @old_event.old_event_groups.each do |group_old_event|
        if (group_index = group_old_events.find_index { |it| it[:group_id].to_s == group_old_event.group_id.to_s })
          group_old_events.delete_at(group_index)
        else
          group_old_events << { id: group_old_event.id, _destroy: true }
        end
      end

      @old_event.update(new_params)
      respond_with @old_event, action: "edit_#{detail}", render: 'edit', location: ->{ root_path }
    end
  end

  def destroy
    authorize @old_event
    @old_event.destroy
    respond_with @old_event, action: "edit_#{@old_event.detail.handle}", location: ->{ root_path }
  end

protected
  def load_old_event
    @old_event = OldEvent.find_by(id: params[:id]) || not_found
  end

private
  def old_event_params(detail)
    params.require(:old_old_event).permit(
      :name,
      :starts_at,
      :start_location,
      :ends_at,
      :end_location,
      :user_in_charge_id,
      :is_hidden,
      :is_private,
      :display_days_amount,
      :description,
      old_event_groups_attributes: [
        :group_id,
      ],
      detail_attributes: [

      ],
    )
  end
end
