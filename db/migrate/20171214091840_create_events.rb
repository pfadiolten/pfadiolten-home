class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events, id: :uuid do |t|
      #
      t.column :name,
               :string,
               null: false

      #
      t.column :is_hidden,
               :boolean,
               null:    false,
               default: false

      #
      t.column :is_private,
               :boolean,
               null: false,
               default: false

      #
      t.column :starts_at,
               :datetime,
               null: false

      #
      t.column :start_location,
               :string,
               null: false

      #
      t.column :ends_at,
               :datetime,
               null: false

      #
      t.column :end_location,
               :string,
               null: true

      #
      t.column :display_days_amount,
               :integer,
               null: true # null = show now

      #
      t.column :user_in_charge_id,
               :uuid,
               null: true # null = user deleted, or default contact selected

      t.index %i[ user_in_charge_id ],
              name: 'user_in_charge_of_event'

      t.foreign_key :users,
                    column: :user_in_charge_id,
                    name: 'fk_user_in_charge_of_event'

      #
      t.column :detail_type,
               :string,
               null: false

      t.column :detail_id,
               :uuid,
               null: false

      t.index %i[ detail_type detail_id ],
              name: 'detail_of_event'

      #
      t.timestamps
    end
  end
end
