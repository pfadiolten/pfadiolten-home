class CreateAlbumArchives < ActiveRecord::Migration[5.1]
  def change
    create_table :album_archives do |t|
      #
      t.column :file,
               :string,
               null: false

      #
      t.column :album_id,
               :integer,
               null: false

      t.index %i[ album_id ],
              name: 'album_of_archive'

      t.foreign_key :albums,
                    column: :album_id,
                    name: 'fk_album_of_archive'

      #
      t.timestamps
    end
  end
end
