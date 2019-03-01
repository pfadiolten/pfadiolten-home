class CreateFileAvatars < ActiveRecord::Migration[5.2]
  def change
    create_table :file_avatars, id: :uuid do |t|
      #
      t.column :file,
               :string,
               null: false

      #
      t.references :avatarable,
                   polymorphic: true,
                   index:       true

      #
      t.timestamps
    end
  end
end
