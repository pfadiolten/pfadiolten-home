class ApplicationUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def filename
    "#{mounted_as}.#{extension}" if original_filename.present?
  end

protected
  def extension
    file.extension
  end

  def fallback(path)
    ActionController::Base.helpers.asset_path('fallback/' + path)
  end
end
