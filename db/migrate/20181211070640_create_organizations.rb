class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations, id: :uuid do |t|
      #
      t.column :name,
               :string,
               null: false

      t.index %i[ name ],
              unique: true,
              name: 'name_of_organization'

      #
      t.column :abbreviation,
               :string,
               null: false

      t.index %i[ abbreviation ],
              unique: true,
              name: 'abbreviation_of_organization'

      #
      t.column :description,
               :text,
               null: true

      #
      t.timestamps
    end
  end
end
