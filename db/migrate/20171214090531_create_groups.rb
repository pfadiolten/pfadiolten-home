class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups, id: :uuid do |t|
      #
      t.column :name,
               :string,
               null: false

      t.index %i[ name ],
              unique: true,
              name: 'name_of_group'

      #
      t.column :abbreviation,
               :string,
               null: false

      t.index %i[ abbreviation ],
              unique: true,
              name: 'abbreviation_of_group'

      #
      t.column :what,
               :text,
               null: true

      #
      t.column :who,
               :string,
               null: true

      #
      t.column :when,
               :string,
               null: true

      #
      t.column :index,
               :integer,
               null: false

      t.index %i[ index ],
              unique: true,
              name: 'index_of_group'

      #
      t.timestamps
    end
  end
end
