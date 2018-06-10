class Group::Member < ApplicationRecord
# Relations
  belongs_to :group,
             class_name: 'Group',
             foreign_key: :group_id,
             required: true

  belongs_to :user,
             class_name: 'User',
             foreign_key: :user_id,
             required: true

  belongs_to :role,
             class_name: 'Group::Role',
             foreign_key: :role_id,
             required: true

# Validations
  validates :user_id,
            uniqueness: { scope: %i[ group_id ] }

  validate :that_role_belongs_to_group

# Actions
  def scout_name
    user.scout_name
  end

  def to_param
    user.to_param
  end

  def that_role_belongs_to_group
    if (role = self.role)
      errors.add(:role, :invalid) if role.group.id != group.id
    end
  end
end
