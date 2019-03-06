class AvatarUploader < ApplicationImageUploader
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
    owner =
      if model.respond_to? :avatarable
        model.avatarable
      else
        # TODO remove this (model.avatarable will be enough) as soon as `User` does not mount the uploader anymore
        model
      end
    "#{(owner.scout_name || owner.id).downcase}.#{extension}"
  end
end
