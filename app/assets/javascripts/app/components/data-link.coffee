$ ->
  $('[data-link]').each query arg ($element) ->
    $element.click (e) ->
      $to = $(e.toElement)
      return if $to.is('a') || $to.data('link')?

      $a = $('<a/>', href: $element.data('link'))
      event = e.originalEvent
      $a[0].dispatchEvent(new event.constructor(event.type, event))
      false


