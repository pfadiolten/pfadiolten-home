class CreateGroupMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :group_members, id: :uuid do |t|
      #
      t.column :group_id,
               :uuid,
               null: false

      t.index %i[ group_id ],
              name: 'group_of_member'

      t.foreign_key :groups,
                    column: :group_id,
                    name: 'fk_group_of_member'

      #
      t.column :user_id,
               :uuid,
               null: false

      t.index %i[ user_id ],
              name: 'user_of_member'

      t.foreign_key :users,
                    column: :user_id,
                    name: 'fk_user_of_member'

      #
      t.column :role_id,
               :uuid,
               null: false

      t.index %i[ role_id ],
              name: 'role_of_member'

      t.foreign_key :group_roles,
                    column: :role_id,
                    name: 'fk_role_of_member'

      #
      t.timestamps

      #
      t.index %i[ group_id user_id ],
              unique: true,
              name: 'unique_group_user_of_member'
    end
  end
end
