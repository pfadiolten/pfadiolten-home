class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      #
      t.column :name,
               :string,
               null: false

      t.index %i[ name ],
              unique: true,
              name: 'name_of_album'

      #
      t.column :description,
               :text,
               null: true

      #
      t.column :images,
               :text,
               null: true

      #
      t.timestamps
    end
  end
end
