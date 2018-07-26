class Album::Image::Uploader < ImageUploader
  version :thumbnail do
    process :equal_sides
    process resize_to_fit: [ 300, 300 ]
  end

  version :gallery do
    process resize_to_limit: [ 500, 500 ]
  end
end
