class RenameEventsToOldEvents < ActiveRecord::Migration[5.2]
  def change
    rename_table :events, :old_events
    rename_table :event_groups, :old_event_groups
    rename_table :event_activity_details, :old_event_activity_details
    rename_table :event_camp_details, :old_event_camp_details
  end
end
