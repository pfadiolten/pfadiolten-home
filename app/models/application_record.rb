class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_validation :clear_blank_values

  def clear_blank_values
    attributes.each_pair do |attribute, value|
      write_attribute(attribute, nil) if value.blank?
    end
  end

  class << self
    def default_for(attribute, is: nil, &block)
      raise 'no default supplier given' if is.nil? && block.nil?
      block ||= ->{ is }
      defaultation = proc do
        value = send(attribute)
        next if value.present?
        send("#{attribute}=", instance_exec(&block))
      end
      before_validation &defaultation
      before_save &defaultation
    end

    SANITIZE_HTML_CONFIG = Sanitize::Config.merge(
      Sanitize::Config::RELAXED,
      attributes: Sanitize::Config::RELAXED[:attributes].merge(
        all: [ :data, 'class' ],
      ),
    )

    def sanitize_html_of(*attributes)
      before_validation do
        attributes.each do |attribute|
          value = send("#{attribute}")
          break if value.blank?
          send("#{attribute}=", Sanitize.fragment(
            value,
            SANITIZE_HTML_CONFIG,
          ))
        end
      end
    end

    def validate_file(attribute, content_type: nil, is_image: false, presence: false)
      validator = proc do
        file = public_send(attribute)
        if presence
          errors.add(:attribute, :required) unless file.attached?
        end
        if is_image
          content_type = Array(content_type) + content_types_for_images
        end
        if content_type.present?
          if file.attached? && !file.content_type.in?(included_in)
            errors.add(attribute, :invalid)
          end
        end
      end
      validate validator
    end

    def content_types_for_images
      %w[ image/png image/jpg image/jpeg ].freeze
    end
  end
end
