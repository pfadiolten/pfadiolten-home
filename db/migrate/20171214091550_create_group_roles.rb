class CreateGroupRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :group_roles, id: :uuid do |t|
      #
      t.column :name,
               :string,
               null: false

      #
      t.column :can_edit_members,
               :boolean,
               null: false,
               default: false

      #
      t.column :can_edit_group,
               :boolean,
               null: false,
               default: false

      #
      t.column :group_id,
               :uuid,
               null: false

      t.index %i[ group_id ],
              name: 'group_of_role'

      t.foreign_key :groups,
                    column: :group_id,
                    name: 'fk_group_of_role'

      #
      t.timestamps

      #
      t.index %i[ name group_id ],
              unique: true,
              name: 'unique_name_of_role'# }
    end
  end
end
