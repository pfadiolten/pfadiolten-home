class Article < ApplicationRecord
  mount_uploader :image, CoverUploader

  paginates_per 5

# Relations
  belongs_to :author,
             class_name: 'User',
             foreign_key: :author_id,
             required: false

# Attributes
  alias_attribute :pinned?, :is_pinned

  default_for :pinned?, is: false

# Scopes
  scope :order_by_release, ->{
    order(created_at: 'desc', title: 'desc')
  }

  scope :pinned, ->{
    where(is_pinned: true)
    .where('pinned_till IS NULL OR pinned_till >= (?)', Date.today)
  }

  scope :not_pinned, ->{
    where(is_pinned: true)
    .or(where('pinned_till IS NOT NULL AND pinned_till < (?)', Date.today))
  }

# Callbacks
  sanitize_html_of :text

# Validations
  validates :title, :text, :summary,
            length: { minimum: 1 },
            presence: true

  validates :pinned_till,
            presence: true,
            allow_nil: true

  validate :that_pin_is_correct


# Actions
  def still_pinned?
    pinned? && (pinned_till.nil? || pinned_till >= Date.today)
  end

  def to_param
    "#{title}@#{id}"
  end

protected
  def that_pin_is_correct
      errors.add(:pinned_till, :invalid) unless pinned? || pinned_till.nil?
  end
end
