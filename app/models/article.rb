class Article < ApplicationRecord
  # TODO remove
  mount_uploader :carrierwave_image, CoverUploader, mount_on: :image

  paginates_per 5

# Relations
  belongs_to :author,
             class_name: 'User',
             foreign_key: :author_id,
             required: false

  has_one :image,
          class_name: 'File::Image',
          as:         :imageable,
          dependent:  :destroy,
          required:   false

# Attributes
  alias_attribute :pinned?, :is_pinned

  default_for :pinned?, is: false

  accepts_nested_attributes_for :image,
                                allow_destroy: true

# Scopes
  scope :order_by_release, ->{
    order('created_at': 'desc', title: 'desc')
  }

  scope :pinned, ->{
    where('pinned?': true)
    .where('pinned_till IS NULL OR pinned_till >= (?)', Date.today)
  }

  scope :not_pinned, ->{
    where('pinned?': false)
    .or(where('pinned_till IS NOT NULL AND pinned_till < (?)', Date.today))
  }

# Callbacks
  sanitize_html_of :text

  after_validation if: ->{ image.present? } do
    image.name = title
  end

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
