class User < ApplicationRecord
# Configuration
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable

  mount_uploader :avatar, AvatarUploader

# Relations
  has_many :members,
           class_name: 'Member',
           foreign_key: :user_id,
           dependent: :destroy

  has_many :groups,
           class_name: 'Group',
           through: :members,
           foreign_key: :group_id

  has_many :roles,
           class_name: 'Role',
           through: :members,
           foreign_key: :role_id

  has_many :events,
           class_name: 'Event',
           foreign_key: :user_in_charge_id,
           dependent: :nullify

  has_many :articles,
           class_name: 'Article',
           foreign_key: :author_id,
           dependent: :nullify

# Attributes
  alias_attribute :admin?, :is_admin

  default_for :admin?, is: false

  sanitize_html_of :description

# Callbacks
  before_validation :make_first_user_an_admin

# Validations
  validates :scout_name,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :first_name, :last_name,
            presence: true

  validates :password,
            confirmation: true

  validates :is_admin,
            inclusion: { in: [ true, false ] }

# Actions
  def name
    "#{first_name} #{last_name}"
  end

  def email
    "#{scout_name.downcase}@pfadiolten.ch"
  end

  def all_names
    "#{scout_name} (#{name})"
  end

  def to_param
    scout_name.downcase
  end

protected
  def make_first_user_an_admin
    self.is_admin = true if User.none?
  end

  class << self
    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = (conditions.delete(:login) || conditions.delete(:scout_name))
        where(conditions.to_h).where('LOWER(scout_name) = LOWER(?)', login).first
      end
    end

    def find_by_scout_name(scout_name)
      find_by('LOWER(scout_name) = LOWER(?)', CGI::unescape(scout_name))
    end
  end
end
