class CreateRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :ranks, id: :uuid do |t|
      #
      t.column :value,
               :integer,
               null: false

      #
      t.references :rankable,
                   polymorphic: true,
                   index:       true,
                   type:        :uuid

      #
      t.timestamps
    end

    add_index :ranks, %i[ value rankable_id rankable_type ],
              unique: true,
              name:   'unique_rank'
  end
end
