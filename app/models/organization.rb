class Organization < ApplicationRecord
# Relations
  has_many :members,
           class_name:  'Organization::Member',
           foreign_key: :organization_id,
           dependent:   :destroy

  has_one :rank,
          class_name: 'Rank',
          as:         :rankable,
          dependent:  :destroy,
          required:   true

# Scopes
  scope :ordered, ->{
    includes(:rank).order('ranks.value')
  }

# Callbacks
  sanitize_html_of :description

  default_for :rank do
    Rank.new(rankable: self)
  end

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