class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events, id: :uuid do |t|
      #
      t.column :title,
               :string,
               null: false

      #
      t.column :description,
               :text,
               null: true

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
      t.column :kind,
               :integer,
               null: false

      #
      t.column :user_in_charge_id,
               :uuid,
               null: true

      t.foreign_key :users,
                    column: :user_in_charge_id

      t.index %i[ user_in_charge_id ]

      #
      t.timestamps
    end
  end
end
