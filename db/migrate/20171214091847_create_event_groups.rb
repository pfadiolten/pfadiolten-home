class CreateEventGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :event_groups, id: :uuid do |t|
      #
      t.column :event_id,
               :uuid,
               null: false

      t.index %i[ event_id ],
              name: 'event_of_group'

      t.foreign_key :events,
                    column: :event_id,
                    name: 'fk_event_of_group'

      #
      t.column :group_id,
               :uuid,
               null: false

      t.index %i[ group_id ],
              name: 'group_of_event'

      t.foreign_key :groups,
                    column: :group_id,
                    name: 'fk_group_of_event'
      #
      t.timestamps

      #
      t.index %i[ event_id group_id ],
              unique: true,
              name: 'unique_event_group'
    end
  end
end
