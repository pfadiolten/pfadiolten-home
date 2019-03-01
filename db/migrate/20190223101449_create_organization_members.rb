class CreateOrganizationMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :organization_members, id: :uuid do |t|
      #
      t.column :first_name,
               :string,
               null: false

      #
      t.column :last_name,
               :string,
               null: false

      #
      t.column :scout_name,
               :string,
               null: true

      t.index %i[ scout_name ],
              name:   'scout_name_of_organization_member',
              unique: true

      #
      t.column :role,
               :string,
               null: true

      #
      t.column :organization_id,
               :uuid,
               null: false

      t.index %i[ organization_id ],
              name: 'organization_of_organization_member'

      t.foreign_key :organizations,
                    column: :organization_id,
                    name:   'fk_organization_of_organization_member'

      #
      t.timestamps
    end

    add_index :organization_members, %i[ first_name last_name ],
              unique: true,
              name:   'full_name_of_organization_member'
  end
end
