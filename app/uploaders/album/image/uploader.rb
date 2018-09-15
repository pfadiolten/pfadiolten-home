class Album::Image::Uploader < ImageUploader
  [ 128, 256, 512, 1024 ].each do |size|
    version :"x#{size}" do
      process resize_to_limit: [ size, size ]
    end
  end
end
