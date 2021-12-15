class RemoveOrganizationMemberUniqueness < ActiveRecord::Migration[5.2]
  def change
    remove_index :organization_members, :scout_name
    remove_index :organization_members, %i[ first_name last_name ]
  end
end
