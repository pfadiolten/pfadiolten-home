class Article < ApplicationRecord
  mount_uploader :image, CoverUploader

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
    order('created_at': 'desc', title: 'desc')
  }

# Callbacks
  sanitize_html_of :text

# Validations
  validates :title, :text,
            length: { minimum: 1 },
            presence: true

  validates :pinned_till,
            presence: true,
            allow_nil: true

  validate :that_pin_is_correct


protected
  def that_pin_is_correct
    errors.add(:pinned_till, :invalid) unless pinned? || pinned_till.nil?
  end
end
