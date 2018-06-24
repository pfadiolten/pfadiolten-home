$  ->
  $('.js-expandable').each query arg ($expandable) ->
    $text     = $expandable.find('.js-expandable__text')
    $togglers = $expandable.find('.js-expandable__toggle')
    $showLess = $togglers.find('.js-expandable__toggle__show-less')
    $showMore = $togglers.find('.js-expandable__toggle__show-more')

    minHeight = '15rem'

    $showMore.click ->
      $text.animate(height: $text[0].scrollHeight, ->
        $text.css(height: '')
      )
      $showLess.show()
      $showMore.hide()

    $showLess.click ->
      $text.animate(height: minHeight)
      $showMore.show()
      $showLess.hide()

    $showLess.hide()
    $text.css(overflow: 'hidden', height: minHeight)