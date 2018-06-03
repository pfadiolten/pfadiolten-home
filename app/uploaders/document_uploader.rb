class DocumentUploader < ApplicationUploader
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def filename
    model.name
  end

  def extension_whitelist
    %w[ jpg jpeg png doc docx pdf txt xlsx xls ]
  end
end