class ApplicationUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :as_png

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
   "#{secure_token}.png" if original_filename.present?
  end

protected
  def fallback(path)
    ActionController::Base.helpers.asset_path('fallback/' + path)
  end

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

  def secure_token
    media_original_filenames_var = :"@#{mounted_as}_original_filenames"

    unless model.instance_variable_get(media_original_filenames_var)
      model.instance_variable_set(media_original_filenames_var, {})
    end

    unless model.instance_variable_get(media_original_filenames_var).map{|k,v| k }.include? original_filename.to_sym
      new_value = model.instance_variable_get(media_original_filenames_var).merge({"#{original_filename}": SecureRandom.uuid})
      model.instance_variable_set(media_original_filenames_var, new_value)
    end

    model.instance_variable_get(media_original_filenames_var)[original_filename.to_sym]
  end
end