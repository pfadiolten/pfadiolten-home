class Album < ApplicationRecord
  require 'zip'

# Relations
  has_many :images,
           class_name:  'Album::Image',
           foreign_key: :album_id,
           dependent:   :destroy

  has_one :archive,
          class_name: 'Album::Archive',
          foreign_key: :album_id,
          dependent:   :destroy

# Attributes
  attr_accessor :new_images,
                :deleted_images

# Scopes
  default_scope do
    order(created_at: 'desc', name: 'desc')
  end

# Callbacks
  sanitize_html_of :description

# Validations
  validates :name,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :description,
            presence: true,
            allow_nil: true

# Actions
  def to_param
    CGI::escape(name.downcase)
  end

  def save_with_images
    transaction do
      raise ActiveRecord::Rollback unless delete_requested_images && save && create_new_images && rebuild_archive
    end
  end

  def destroy_with_images
    transaction do
      images.each do |image|
        unless image.destroy
          image.errors.each { |err| errors.add(:images, err) }
          raise ActiveRecord::Rollback
        end
      end
      destroy
    end
  end

private
  def delete_requested_images
    (deleted_images || []).each do |image|
      unless image.destroy
        image.errors.each { |err| errors.add(:deleted_images, err) }
        return false
      end
    end
    true
  end

  def create_new_images
    (new_images || []).each do |image_file|
      image = Album::Image.new(album: self)
      image.file = image_file.tap(&:open)
      unless image.save
        raise image.errors.to_hash.to_s
        image.errors.each { |err| errors.add(:new_images, err) }
        return false
      end
      images << image
    end
    true
  end

  def rebuild_archive
    return false if archive.present? and not archive.destroy
    self.archive = Archive.new(album: self)
    archive.save
  end
end
