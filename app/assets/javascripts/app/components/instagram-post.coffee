$ ->
  $('.js-instagram-post').each query arg ($post) ->
    link = $post.data('instagram-link')
    $.get("https://api.instagram.com/oembed?url=#{link}", (data) ->
      $post.replaceWith(data.html)
    ).fail (args...) ->
      console.error("failed to load instagram post (link: #{link}): #{args}")
