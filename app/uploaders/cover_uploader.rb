class CoverUploader < ApplicationUploader
  include CarrierWave::MiniMagick

  storage :file

  def extension_whitelist
    %w[ jpg jpeg png ]
  end
end
