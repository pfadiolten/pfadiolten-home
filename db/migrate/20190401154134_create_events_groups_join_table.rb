class CreateEventsGroupsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :events, :groups, {
      column_options: {
        index: true,
        type:  :uuid,
      }
    }
  end
end
