class Article < ApplicationRecord
  mount_uploader :image, CoverUploader

# Relations
  belongs_to :author,
             class_name: 'User',
             foreign_key: :author_id,
             required: false

# Scopes
  scope :order_by_release, ->{
    order('created_at': 'desc', title: 'desc')
  }

# Validations
  validates :title, :text,
            length: { minimum: 1 },
            presence: true
end
