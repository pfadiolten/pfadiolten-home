class Group < ApplicationRecord
# Relations
  has_many :roles,
           class_name: 'Group::Role',
           foreign_key: :group_id,
           dependent: :destroy

  has_many :members,
           class_name: 'Member',
           foreign_key: :group_id,
           dependent: :destroy

  has_many :users,
           class_name: 'User',
           through: :members,
           foreign_key: :user_id

  has_many :event_groups,
           class_name: 'EventGroup',
           foreign_key: :group_id,
           dependent: :destroy

  has_many :events,
           class_name: 'Event',
           through: :event_groups,
           foreign_key: :event_id

# Scopes
  default_scope do
    order(index: 'asc')
  end

# Callbacks
  before_validation :load_index, on: %i[ create ]

  sanitize_html_of :what

# Validations
  validates :name,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :abbreviation,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :index,
            uniqueness: true

  validates :what, :who, :when,
            length: { minimum: 1, allow_nil: true }

# Actions
  def to_param
    abbreviation.downcase
  end

protected
  def load_index
    return if index.present?

    self.index =
      if last_group = Group.all.reorder(index: 'desc').first
        last_group.index + 1
      else
        0
      end
  end
end
