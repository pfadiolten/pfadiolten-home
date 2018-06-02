class Album < ApplicationRecord
# Relations
  has_many :images,
           class_name:  'AlbumImage',
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

  before_save do
    images.each do |image|
      false unless image.save
    end
  end

# Validations
  validates :name,
            uniqueness: { case_sensitive: false },
            presence: true

  validates :description,
            presence: true,
            allow_nil: true

# Actions
  def name_for_zip
    name.gsub(/[^ a-zA-Z_\-0-9.]/, '_')
  end

  def to_param
    CGI::escape(name.downcase)
  end

  def save_with_images
    transaction do
      raise ActiveRecord::Rollback unless delete_requested_images && save && create_new_images
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
      image = AlbumImage.new(album: self)
      image.file = image_file
      unless image.save
        image.errors.each { |err| errors.add(:new_images, err) }
        return false
      end
      images << image
    end
    true
  end
end
