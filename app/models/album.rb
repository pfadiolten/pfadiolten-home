class Album < ApplicationRecord
# Configuration
  mount_uploaders :images, AlbumUploader

# Attributes
  serialize :images, JSON

# Validations
  validates :name,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :description,
            presence: true,
            allow_nil: true

# Scopes
  default_scope do
    order(created_at: 'desc', name: 'desc')
  end

# Actions
  def name_for_file
    name.gsub(/[^ a-zA-Z_\-0-9.]/, '_')
  end

  def to_param
    CGI::escape(name.downcase)
  end
end
