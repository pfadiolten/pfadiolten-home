class ImageUploader < ApplicationUploader
  include CarrierWave::MiniMagick
  # MiniMagick.logger.level = Logger::DEBUG

  process :as_png

  def extension_whitelist
    %w[ jpg jpeg png ]
  end

protected
  def as_png
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

  def extension
    'png'
  end
end