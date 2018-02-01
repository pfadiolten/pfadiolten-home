class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      #
      t.column :title,
               :string,
               null: false

      #
      t.column :summary,
               :text,
               null: false

      #
      t.column :text,
               :text,
               null: false

      #
      t.column :image,
               :string,
               null: true

      #
      t.column :is_pinned,
               :boolean,
               null: false

      #
      t.column :pinned_till,
               :date,
               null: true

      #
      t.column :author_id,
               :integer,
               null: true # null = user deleted

      t.index %i[ author_id ],
              name: 'author_of_article'

      t.foreign_key :users,
                    column: :author_id,
                    name: 'fk_author_of_article'

      #
      t.timestamps
    end
  end
end
