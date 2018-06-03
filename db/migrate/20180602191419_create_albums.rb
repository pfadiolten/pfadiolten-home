class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    drop_table :album_archives if ActiveRecord::Base.connection.data_source_exists? :album_archives
    drop_table :album_images if ActiveRecord::Base.connection.data_source_exists? :album_images
    drop_table :albums if ActiveRecord::Base.connection.data_source_exists? :albums
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
      t.timestamps
    end
  end
end
