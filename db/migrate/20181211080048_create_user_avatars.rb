class CreateUserAvatars < ActiveRecord::Migration[5.2]
  def change
    create_table :user_avatars, id: :uuid do |t|
      #
      t.column :user_id,
               :integer,
               null: false

      t.index %i[ user_id ],
              unique: true,
              name:   'user_of_avatar'

      t.foreign_key :users,
                    column: :user_id,
                    name: 'fk_user_of_avatar'

      #
      t.timestamps
    end
  end
end
