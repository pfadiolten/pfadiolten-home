class Organization::Member < ApplicationRecord
# Relations
  belongs_to :organization,
             class_name:  'Organization',
             foreign_key: :organization_id,
             required:    true

  has_one :avatar,
          class_name: 'File::Avatar',
          as:         :avatarable,
          dependent:  :destroy

# Scopes
  scope :ordered, ->{
    order(:role, :scout_name, :first_name, :last_name)
  }

  def self.find_by_name(name)
    find_by('LOWER(scout_name) = LOWER(?)', name) || find_by("LOWER(first_name || ' ' || last_name) = ?", name)
  end

# Callbacks
  before_validation do
    next if avatar.file?

    avatar.destroy! if avatar.persisted?
    self.avatar = nil
  end

# Attributes
  accepts_nested_attributes_for :avatar,
                                allow_destroy: true

# Validations
  validates :first_name,
            presence:   true,
            uniqueness: { scope: %i[ last_name organization_id ], case_sensitive: false, }

  validates :last_name,
            presence:   true,
            uniqueness: { scope: %i[ first_name organization_id ], case_sensitive: false, }

  validates :scout_name,
            presence:   true,
            allow_nil:  true

  validates :role,
            presence:  true,
            allow_nil: true

# Methods
  def to_param
    name.downcase
  end

  def name
    scout_name || full_name
  end

  def full_name
    @_full_name ||= "#{first_name} #{last_name}"
  end
end
