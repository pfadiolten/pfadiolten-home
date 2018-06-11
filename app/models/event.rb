class Event < ApplicationRecord
# Relations
  belongs_to :user_in_charge,
             class_name: 'User',
             foreign_key: :user_in_charge_id,
             required: false

  belongs_to :detail,
             polymorphic: true,
             foreign_key: :detail_id,
             required:    true,
             dependent:   :destroy

  has_many :event_groups,
           class_name:  'EventGroup',
           inverse_of:  :event,
           foreign_key: :event_id,
           dependent:   :destroy

  has_many :groups,
           class_name: 'Group',
           through:     :event_groups,
           foreign_key: :event_id

# Attributes
  accepts_nested_attributes_for :event_groups, allow_destroy: true

  accepts_nested_attributes_for :detail, allow_destroy: true

  alias_attribute :hidden?, :is_hidden

  alias_attribute :private?, :is_private

  serialize :documents, Hash

  default_for :hidden?, is: false

  default_for :private?, is: false

# Scopes
  default_scope do
    order(starts_at: 'asc')
  end

  scope :active, ->{
    self
      .where(hidden?: false)
      .where('ends_at >= (?)', Date.today)
      .where('(display_days_amount IS NULL) OR (CAST (starts_at AS DATE) - display_days_amount) <= (?)', Date.today)
  }

# Callbacks
  before_validation :filter_event_groups

# Validations
  validates :name,
            length: { minimum: 1 },
            presence: true

  validates :display_days_amount,
            numericality: { greater_than_or_equal_to: 0, only_integer: true },
            allow_nil: true

  validates :starts_at, :start_location, :ends_at,
            presence: true

  validate :that_start_is_before_end

# Actions
  def that_start_is_before_end
    errors.add(:ends_at, :invalid) if starts_at >= ends_at
  end

  def show_in_calendar?
    true
  end

  def show_on_news?
    show_in_calendar? || event.display_days_amount == nil || (Date.today - event.starts_at).to_i > event.display_days_amount
  end

  def same_day?
    starts_at.to_date == ends_at.to_date
  end

  def same_location?
    start_location.downcase == end_location.downcase
  end

  def full_start_location
    start_location
  end

  def full_end_location
    end_location || full_start_location
  end

protected
  def filter_event_groups
    self.event_groups = self.event_groups.select { |it| it.group_id.present? }
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
