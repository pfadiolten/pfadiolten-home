class Organization < ApplicationRecord

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
