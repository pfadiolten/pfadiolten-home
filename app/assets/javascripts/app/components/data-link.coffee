$ ->
  $('[data-link]').each query arg ($element) ->
    $element.click (e) ->
      $parent = $(e.originalEvent.srcElement)
      while ($parent = $parent.parent())[0] != $element[0]
        return if $parent.is('a')

      $to = $(e.toElement)
      return if $to.is('a') || $to.data('link')?

      $a = $('<a/>', href: $element.data('link'))
      event = e.originalEvent
      $a[0].dispatchEvent(new event.constructor(event.type, event))
      false


