class Event < ApplicationRecord
# Relations
  belongs_to :user_in_charge,
             class_name: 'User',
             foreign_key: :user_in_charge_id,
             required: false

  belongs_to :detail,
             polymorphic: true,
             foreign_key: :detail_id,
             required:    true

  has_many :event_groups,
           class_name:  'EventGroup',
           inverse_of:  :event,
           foreign_key: :event_id,
           dependent:   :destroy

  has_many :groups,
           class_name: 'EventGroup',
           through:     :event_groups,
           foreign_key: :event_id

  has_many :documents,
           class_name:  'Document',
           as:          'context',
           foreign_key: :context_id

# Attributes
  accepts_nested_attributes_for :event_groups, allow_destroy: true

  alias_attribute :hidden?, :is_hidden

  alias_attribute :private?, :is_private

  default_for :hidden?, is: false

  default_for :private?, is: false

  serialize :documents, Hash

# Scopes
  default_scope do
    order(starts_at: 'asc')
  end

  scope :active, ->{
    self
      .where(hidden?: false)
      .where('ends_at >= (?)', Date.today)
      .where('(starts_at - show_x_days_before_start) >= (?)', Date.today)
  }

# Validations
  validates :name,
            length: { minimum: 1 },
            presence: true

  validates :hidden?, :private?,
            inclusion: { in: [ true, false ] },
            presence: true

  validates :show_x_days_before_start,
            numericality: { greater_than_or_equal_to: 0, only_integer: true },
            presence: true

  validates :starts_at, :start_location, :ends_at,
            presence: true

  validate :that_start_is_before_end

# Actions
  def that_start_is_before_end
    errors.add(:ends_at, :invalid) if starts_at >= ends_at
  end

  def same_day?
    starts_at.to_date == ends_at.to_date
  end

  def same_location?
    start_location.downcase == end_location.downcase
  end

  class << self
    def detail_types
      {
        activity: Event::ActivityDetail,
        camp:     Event::CampDetail,
      }
    end
  end
end
