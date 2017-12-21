module ArticlesHelper
  def article_info(article)
    created_at = l(article.created_at.to_date, format: :long)
    if author = article.author
      link_to "#{author.scout_name}, #{created_at}", user_path(author), class: 'btn btn-default'
    else
      content_tag('div', created_at, class: 'label label-default')
    end
  end
end
