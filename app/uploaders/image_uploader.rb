# NOTE:
# Any problems with this uploader or it's children might be related to minimagick.
# Make sure either imagemagick or graphicsmagick is installed on the system.

class ImageUploader < ApplicationUploader
  include CarrierWave::MiniMagick
  #(MiniMagick.logger.level = Logger::DEBUG) if Rails.env.development?

  process :image_defaults

  def extension_whitelist
    %w[ jpg jpeg png ]
  end

protected
  def image_defaults
    manipulate! do |image|
      #image.format('png')
      image.auto_orient
    end
  end

  def equal_sides
    manipulate! do |image|
      w, h = image.width, image.height
      unless w == h
        length = if w > h then w else h end
        image.combine_options do |b|
          b.background('white')
          b.gravity('center')
          b.extent("#{length}x#{length}")
          b.transparent('white')
        end
      end
      image
    end
  end
end