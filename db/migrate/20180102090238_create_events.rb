class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      #
      t.column :name,
               :string,
               null: false

      #
      t.column :is_hidden,
               :bool,
               null:    false,
               default: false

      #
      t.column :is_private,
               :bool,
               null: false,
               default: false

      #
      t.column :starts_at,
               :datetime,
               required: true

      #
      t.column :start_location,
               :datetime,
               required: false

      #
      t.column :ends_at,
               :datetime,
               required: true

      #
      t.column :end_location,
               :datetime,
               required: false

      #
      t.column :show_x_days_before_start,
               :long,
               null: true # null = show now

      #
      t.column :user_in_charge_id,
               :integer,
               null: true # null = user deleted, or default contact selected

      t.index %i[ user_in_charge_id ],
              name: 'user_in_charge_of_event'

      t.foreign_key :users,
                    column: :user_in_charge_id,
                    name: 'fk_user_in_charge_of_event'

      #
      t.column :detail_type,
               :string,
               required: true

      t.column :detail_id,
               :integer,
               required: true

      t.index %i[ detail_type detail_id ],
              name: 'detail_of_event'

      #
      t.timestamps
    end
  end
end
