class File::Image < File::Base
  self.table_name = model_name.plural

# Relations
  belongs_to :imageable,
             polymorphic: true,
             required:    true

# Attributes
  mount_uploader :old_file, ImageUploader, mount_on: :file

# Validations
  validate { that_content_type_is %w[ image/png image/jpg image/jpeg image/webp ] }

# Methods
  def process
    ImageBuilder.new(file).optimized
  end

  class ImageBuilder
    def initialize(image, options = {})
      @image   = image
      @options = options
    end

    def resize_to_limit(width, height = width)
      continue_with(
        resize: "#{width}x#{height}>"
      )
    end

    def resize_to_fit(width, height = width)
      continue_with(
        resize: "#{width}x#{height}"
      )
    end

    def resize_to_fill(width, height = width)
      @image.blob.analyze unless @image.blob.analyzed?

      cols = @image.blob.metadata[:width].to_f
      rows = @image.blob.metadata[:height].to_f
      if width != cols || height != rows
        scale_x = width / cols
        scale_y = height / rows
        if scale_x >= scale_y
          cols = (scale_x * (cols + 0.5)).round
          resize = cols.to_s
        else
          rows = (scale_y * (rows + 0.5)).round
          resize = "x#{rows}"
        end
      end

      continue_with(
        resize:     resize,
        gravity:    'Center',
        background: 'rgba(255,255,255,0.0)',
        extent:     cols != width || rows != height ? "#{width}x#{height}" : ''
      )
    end

    def resize_and_pad(width, height = width)
      continue_with(
        thumbnail:  "#{width}x#{height}>",
        background: 'rgba(255, 255, 255, 0.0)',
        gravity:    'Center',
        extent:     "#{width}x#{height}"
      )
    end

    def optimized
      if jpeg?
        optimize_jpeg
      else
        optimize
      end
    end

    def apply
      @image.variant(combine_options: @options)
    end

    def to_url_resource
      apply
    end

  private
    def continue_with(**options)
      ImageBuilder.new(@image, @options.merge(options))
    end

    def jpeg?
      @image.blob.content_type.include? 'jpeg'
    end

    def optimize
      continue_with(
        strip: true
      )
    end

    def optimize_jpeg
      continue_with(
        strip:             true,
        'sampling-factor': '4:2:0',
        quality:           '85',
        interlace:         'JPEG',
        colorspace:        'sRGB'
      )
    end
  end
end