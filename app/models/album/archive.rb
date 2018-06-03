class Album::Archive < ApplicationRecord
# Relations
  belongs_to :album,
             class_name:  'Album',
             foreign_key: :album_id

# Attributes
  mount_uploader :file, Album::Archive::Uploader

# Callbacks
  before_validation :create_file, on: :create

# Validations
  validates :file,
            presence: true

# Actions
  def filename
    album.name.gsub(/[^ a-zA-Z_\-0-9.]/, '_') + File.extname(file.path)
  end

  def mimetype
    MIME::Types.type_for(file.path).first.content_type
  end

protected
  def create_file
    create_empty_file
    insert_images_into_file
  end

private
  def create_empty_file
    file = Zippy.new.tap(&:close)
    self.file = File.open(file.filename)
  end

  def insert_images_into_file
    Zippy.open(file.path) do |zip|
      album.images.each_with_index do |image, i|
        File.open(image.file.path, 'rb') do |file|
          zip["#{i}#{File.extname(image.file.path)}"] = file.read
        end
      end
    end
  end
end
