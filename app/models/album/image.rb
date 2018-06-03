class Album::Image < ApplicationRecord
# Relations
  belongs_to :album,
             class_name:  'Album',
             foreign_key: :album_id

# Attributes
  mount_uploader :file, Album::Image::Uploader

# Validations
  validates :file,
            presence: true

# Scopes
  default_scope do
    order(created_at: 'desc')
  end
end
