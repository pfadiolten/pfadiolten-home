class File::Base < ApplicationRecord
  extend ActiveSupport::Concern

  self.abstract_class = true

# Attributes
  has_one_attached :file

  attr_accessor :name

# Callbacks
  before_save do
    next if name.nil?
    extension = file.filename.extension
    new_filename = ActiveStorage::Filename.new("#{name.downcase}.#{extension}")
    file.blob.update(filename: new_filename.sanitized)
  end

# Validations
  validate :that_file_is_present

# Methods
  def name
    return @name if @name.present?
    file.filename.base
  end

private
  def that_file_is_present
    return if file.attached?
    file.purge
    errors.add(:file, :empty)
  end

  def that_content_type_is(mime_types)
    mime_types = mime_types.map(&Regexp.method(:new)).freeze
    return unless file.attached?
    content_type = file.blob.content_type
    return if mime_types.any? { |mime| mime =~ content_type }
    file.purge
    errors.add(:file, :invalid)
  end

  def that_byte_size_ranges(range)
    return unless file.attached?
    byte_size = file.blob.byte_size
    return unless range.include?(byte_size)

    file.purge
    if byte_size < range.begin
      errors.add(:file, :greater_than_or_equal_to, "#{range.begin}b")
    else
      errors.add(:file, :less_than_or_equal_to, "#{range.end}b")
    end
  end
end