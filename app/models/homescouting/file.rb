class Homescouting::File < ApplicationRecord
  paginates_per 10

  has_one_attached :file,
                   dependent: :destroy

  validate :validate_file

  # Actions
  def validate_file
    unless file.attached?
      errors[:file] << 'fehlt'
      return
    end

    unless file.blob.content_type.starts_with?('image/')
      file.purge
      errors[:file] << 'hat falsches Format'
    end
  end
end
