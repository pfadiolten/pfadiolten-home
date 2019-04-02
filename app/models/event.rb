class Event < ApplicationRecord
# Relations
  belongs_to :user_in_charge, {
    class_name: 'User',
    required:   false,

  }

  has_and_belongs_to_many :groups, {
    class_name: 'Group'
  }

# Validations
  validates :title, {
    presence: true
  }

  validates :description, {
    presence:  true,
    allow_nil: true,
  }

  validates :type, {
    presence: true,
  }

  validates :starts_at, :start_location, :ends_at, :end_location, {
    presence: true,
  }

  validate :it_ends_after_start

# Attributes
  enum type: %i[ activity camp holidays other ]

# Scope
  scope :active, ->{
    where('ends_at >= CURRENT_DATE')
  }

  scope :of_year, ->(year) {
    where('DATE_PART("year", starts_at) == :year OR DATE_PART("year", ends_at) == :year', year: year)
  }

  scope :of_month, ->(month) {
    where('DATE_PART("month", starts_at) == :month OR DATE_PART("month", ends_at) == :month', month: month)
  }

# Methods
  def to_param
    "#{name}@#{id}"
  end

  def it_ends_after_start
    errors.add(:ends_at, :invalid) if starts_at >= ends_at
  end
end