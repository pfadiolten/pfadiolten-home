$ ->
  $('[data-link]').each query arg ($element) ->
    $element.css(cursor: 'pointer')
    $element.wrap($('<a>', href: $element.data('link'), class: 'unstyle'))

    ###
    $element.click (e) ->
      while ($parent = $parent.parent())[0] != $element[0]
        return if $parent.is('a')
      $to = $(e.toElement)
      return if $to.is('a') || $to.data('link')?
      $a = $('<a/>', href: $element.data('link'))
      $a[0].dispatchEvent(new event.constructor(event.type, event))
      false
    ###

