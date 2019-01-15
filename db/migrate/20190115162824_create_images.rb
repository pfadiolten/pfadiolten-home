class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images, id: :uuid do |t|
      #
      t.column :file,
               :string,
               null: false

      #
      t.references :imageable,
                   polymorphic: true,
                   index: true

      #
      t.timestamps
    end
  end
end
