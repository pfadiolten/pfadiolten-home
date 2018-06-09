class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents, id: :uuid do |t|
      #
      t.column :name,
               :string,
               null: false

      #
      t.column :link,
               :string,
               null: false

      #
      t.column :context_type,
               :string,
               null: false

      t.column :context_id,
               :uuid,
               null: false

      t.index %i[ context_type context_id ],
              name: 'context_of_document'

      #
      t.timestamps
    end
  end
end
