class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      #
      t.column :name,
               :string,
               null: false

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
               null: false

      #
      t.column :bring_with_you,
               :text,
               null: true

      #
      t.column :other_stuff,
               :text,
               null: true

      #
      t.column :user_in_charge_id,
               :integer,
               null: true # null = user was deleted

      t.index %i[ user_in_charge_id ],
              name: 'user_in_charge_of_event'

      t.foreign_key :users,
                    column: :user_in_charge_id,
                    name: 'fk_user_in_charge_of_event'

      #
      t.timestamps
    end
  end
end
