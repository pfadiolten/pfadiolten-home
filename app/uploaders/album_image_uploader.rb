class AlbumImageUploader < ApplicationUploader
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumbnail do
    process :equal_sides
    process resize_to_fit: [ 500, 500 ]
  end

  version :gallery do
    process resize_to_limit: [ 1000, 1000 ]
  end

  def extension_whitelist
    %w[ jpg jpeg png ]
  end
end
