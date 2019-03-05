class CreateFileImages < ActiveRecord::Migration[5.2]
  def change
    create_table :file_images, id: :uuid do |t|
      #
      t.column :file,
               :string,
               null: false

      #
      t.references :imageable,
                   polymorphic: true,
                   index:       true,
                   type:        :uuid

      #
      t.timestamps
    end
  end
end
