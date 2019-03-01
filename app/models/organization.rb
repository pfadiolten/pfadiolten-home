class Organization < ApplicationRecord
# Relations
  has_many :members,
           class_name:  'Organization::Member',
           foreign_key: :organization_id,
           dependent:   :destroy

  has_one :image,
          class_name: 'File::Image',
          as:         :imageable,
          dependent:  :destroy

# Callbacks
  sanitize_html_of :description

# Validations
  validates :name,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :abbreviation,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :description, :introduction,
            presence: true

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