class File::Avatar < ApplicationRecord
# Relations
  belongs_to :avatarable,
             polymorphic: true,
             required:    true

# Attributes
  mount_uploader :file, AvatarUploader
end
