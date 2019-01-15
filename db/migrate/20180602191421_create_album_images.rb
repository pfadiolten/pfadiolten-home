class CreateAlbumImages < ActiveRecord::Migration[5.1]
  def change
    create_table :album_images, id: :uuid do |t|
      #
      t.column :file,
               :string,
               null: false

      #
      t.column :album_id,
               :uuid,
               null: false

      t.index %i[ album_id ],
              name: 'album_of_image'

      t.foreign_key :albums,
                    column: :album_id,
                    name: 'fk_album_of_image'

      #
      t.timestamps
    end
  end
end