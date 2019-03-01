class File::Avatar < ApplicationRecord
  self.table_name = 'file_avatars'

# Relations
  belongs_to :avatarable,
             polymorphic: true,
             required:    true

# Attributes
  mount_uploader :file, AvatarUploader

# Validations
  validates :file,
            presence: true
end
