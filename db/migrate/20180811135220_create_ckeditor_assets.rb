class CreateCkeditorAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :ckeditor_assets, id: :uuid do |t|
      t.string  :data_file_name, null: false
      t.string  :data_content_type
      t.integer :data_file_size
      t.string  :type, limit: 30

      # Uncomment it to save images dimensions, if your need it
      t.integer :width
      t.integer :height

      t.timestamps null: false
    end

    add_index :ckeditor_assets, :type
  end
end
