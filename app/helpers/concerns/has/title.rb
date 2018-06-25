module Has::Title
  def title(title_or_options=nil)
    if title_or_options.nil? || title_or_options.is_a?(Hash)
      title = t('.title', { default: '' }.merge(title_or_options || {}))
      content_for(:title, title) if title.length > 0
    else
      content_for(:title, title_or_options)
    end
  end

  def tab_title=(value)
    @_tab_title = value
  end

  def tab_title
    @_tab_title || content_for(:title)
  end

  def subtitle(subtitle=nil, &block)
    if subtitle.present?
      content_for(:subtitle, subtitle)
    elsif block_given?
      content_for :subtitle, &block
    else
      subtitle = t('.subtitle', default: '')
      content_for(:subtitle, subtitle) if subtitle.length > 0
    end
  end

  def subtitle_to(record_or_path, name_method=nil, &get_name)
    if record_or_path.is_a?(String) || record_or_path.is_a?(Symbol)
      subtitle(link_to(name_method || get_name.(), record_or_path))
    else
      record = record_or_path
      name =
        if block_given?
          get_name.()
        elsif name_method.present?
          record.send(name_method)
        else
          record.to_s
        end
      subtitle(link_to(name, url_for(record)))
    end
  end
end