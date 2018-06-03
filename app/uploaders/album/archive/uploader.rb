class Album::Archive::Uploader < ApplicationUploader
  def extension_whitelist
    %w[ zip ]
  end
end