class Group::Role < ApplicationRecord
# Relations
  belongs_to :group,
             class_name: 'Group',
             foreign_key: :group_id,
             required: true

  has_many :members,
           class_name: 'Member',
           foreign_key: :role_id,
           dependent: :destroy

  has_many :users,
           class_name: 'User',
           through: :members,
           foreign_key: :user_id

# Attributes
  default_for :can_edit_members, is: false

  default_for :can_edit_group, is: false

# Scopes
  scope :with_members, ->{
    joins(:members).having("COUNT(group_members.id) > 0").group(:id)
  }

  scope :sorted_by_rights, ->{
    order(created_at: 'desc').sort_by(&:rights_value).reverse
  }

# Validations
  validates :name,
            uniqueness: { scope: %i[ group_id ] },
            presence: true

  validates :can_edit_members, :can_edit_group,
            inclusion: { in: [ true, false ] }

# Actions
  def rights_value
    value = 0
    value += 2 if can_edit_members?
    value += 1 if can_edit_group?
    value
  end

  def rights
    Hash[self.class.rights_attributes.map { |it| [ it, send(it) ] }]
  end

  def to_param
    name.downcase
  end

  class << self
    def rights_attributes
      %i[ can_edit_group can_edit_members ]
    end
  end
end
