class AvatarUploader < ImageUploader
  def default_url(*_args)
    fallback [ version_name, 'avatar.png' ].compact.join('_')
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/"
  end

  def filename
    make_filename if original_filename.present?
  end

  process :equal_sides

  process resize_to_fit: [ 1000, 1000 ]

  version :normal do
    process resize_to_fit: [ 500, 500 ]
  end

  version :thumbnail do
    process resize_to_fit: [ 300, 300 ]
  end

  private
  def make_filename
    "#{model.scout_name.downcase}.png"
  end
end
