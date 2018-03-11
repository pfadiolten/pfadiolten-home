module Has::Grid

  def col(**sizes, &block)
    classes = sizes.inject('') do |string, (k, v)|
      string <<
          if string.blank?
            ''
          else
            ' '
          end
      string << "col-#{k}-#{v}"
      string << " col-#{k}-offset-#{(12 - v) / 2}"
      string
    end

    content_tag('div', class: classes) do
      block.()
    end
  end

end