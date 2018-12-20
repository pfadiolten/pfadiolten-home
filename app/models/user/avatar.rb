class User::Avatar < ApplicationRecord
# Relations
  belongs_to :user,
             class_name: 'User',
             foreign_key: :user_id,
             required:    true

# Attributes
  has_one_attached :file

# Validations
  validate_file :file,
                presence: true,
                is_image: true
end
