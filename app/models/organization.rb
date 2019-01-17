class Organization < ApplicationRecord
# Relations
  has_many :images,
           class_name: 'Image',
           as:         'imageable'

# Callbacks
  sanitize_html_of :description

# Validations
  validates :name,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :abbreviation,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :description,
            presence: true,
            allow_nil: true

# Methods
  def to_param
    abbreviation.downcase
  end
end

class << ApplicationRecord
  def find_by_abbreviation(abbreviation)
    find_by('LOWER(abbreviation) = LOWER(?)', abbreviation)
  end
end