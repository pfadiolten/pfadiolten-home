class Event < ApplicationRecord
# Relations
  belongs_to :user_in_charge,
             class_name: 'User',
             foreign_key: :user_in_charge_id,
             required: false

  has_many :event_groups,
           class_name: 'EventGroup',
           inverse_of: :event,
           foreign_key: :event_id,
           dependent: :destroy

  has_many :groups,
           class_name: 'Group',
           through: :event_groups,
           foreign_key: :group_id

# Attributes
  accepts_nested_attributes_for :event_groups, allow_destroy: true

# Scopes
  default_scope do
    order(starts_at: 'asc')
  end

  scope :active, ->{
    where('ends_at >= (?)', Date.today)
  }

# Validations
  validates :name,
            length: { minimum: 1 },
            presence: true

  validates :starts_at, :ends_at,
            presence: true

  validates :start_location, :end_location,
            presence: true

  validates :bring_with_you, :other_stuff,
            presence: true,
            allow_nil: true

  validate :that_start_is_before_end

# Actions
  def that_start_is_before_end
    if starts_at > ends_at
      errors.add(:starts_at, :invalid)
    end
  end

  def same_day?
    starts_at.to_date == ends_at.to_date
  end

  def same_location?
    start_location.downcase == end_location.downcase
  end
end
