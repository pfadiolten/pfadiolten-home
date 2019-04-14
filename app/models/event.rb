class Event < ApplicationRecord
# Relations
  belongs_to :user_in_charge, {
    class_name: 'User',
    required:   false,

  }

  has_and_belongs_to_many :groups, {
    class_name: 'Group'
  }

# Attributes
  enum kind: %i[ activity camp holidays other ]

  # Validations
  validates :title, {
    presence: true
  }

  validates :description, {
    presence:  true,
    allow_nil: true,
  }

  validates :kind, {
    presence: true,
  }

  validates :starts_at, :start_location, :ends_at, :end_location, {
    presence: true,
  }

  validate :it_ends_after_start

# Scope
  scope :active, ->{
    where('ends_at >= CURRENT_DATE')
  }

  scope :of_year, ->(year) {
    where("DATE_PART('year', starts_at) = :year OR DATE_PART('year', ends_at) = :year", year: year)
  }

  scope :of_month, ->(month) {
    where("DATE_PART('month', starts_at) = :month OR DATE_PART('month', ends_at) = :month", month: month)
  }

# Callbacks
  sanitize_html_of :description

# Methods
  def to_param
    "#{title}@#{id}"
  end

  def it_ends_after_start
    errors.add(:ends_at, :invalid) if starts_at >= ends_at
  end
end