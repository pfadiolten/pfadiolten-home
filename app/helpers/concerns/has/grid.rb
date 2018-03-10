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

      if (offset = (12 - v) / 2) > 0
        string << " col-#{k}-offset-#{offset}"
      end
    end

    content_tag('div', class: classes) do
      block.()
    end
  end

end