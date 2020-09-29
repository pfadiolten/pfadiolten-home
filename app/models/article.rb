class Article < ApplicationRecord
  mount_uploader :image, CoverUploader

  paginates_per 5

# Relations
  belongs_to :author,
             class_name: 'User',
             foreign_key: :author_id,
             required: false

# Scopes
  scope :order_by_release, ->{
    order('created_at': 'desc', title: 'desc')
  }

# Callbacks
  sanitize_html_of :text

# Validations
  validates :title, :text, :summary,
            length: { minimum: 1 },
            presence: true

# Actions
  def to_param
    "#{title}@#{id}"
  end
end
