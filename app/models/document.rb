class Document < ApplicationRecord
# Relations
  belongs_to :context,
             polymorphic: true

# Attributes
  mount_uploader :link, DocumentUploader

# Validations
  validates :name,
            uniqueness: { scope: %i[ context_type context_id ] },
            presence: true

  validates :link,
            presence: true
end
