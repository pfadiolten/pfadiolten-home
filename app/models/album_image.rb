class AlbumImage < ApplicationRecord
# Relations
  belongs_to :album,
             class_name:  'Album',
             foreign_key: :album_id

# Configuration
  mount_uploader :file, AlbumImageUploader

# Scopes
  default_scope do
    order(created_at: 'desc')
  end
end
