class AvatarUploader < ImageUploader
  process resize_to_fit: [ 1024, 1024 ]

  [ 32, 64, 128, 256, 512 ].each do |size|
    version :"x#{size}" do
      process resize_to_fill: [ size, size ]
    end
  end

  def default_url(*_args)
    version_name = self.version_name || 'x1024'
    fallback "avatar/#{version_name}.jpg"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/"
  end

  def filename
    make_filename if original_filename.present?
  end

  private
  def make_filename
    "#{model.scout_name.downcase}.png"
  end
end
