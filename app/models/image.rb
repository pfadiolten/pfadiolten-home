class Image < ApplicationRecord
# Relations
  belongs_to :imageable,
             polymorphic: true,
             required:    true

# Attributes
  mount_uploader :file, ImageUploader

# Validations
  validates :file,
            presence: true
end
