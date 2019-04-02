App.components['link'] = ($target) ->
  args =
    url: $target.data('url')

  $target
    .css(cursor: 'pointer')
    .wrap($('<a>', href: args.url, class: 'unstyle'))

  ###
  $element.click (e) ->
    while ($parent = $parent.parent())[0] != $element[0]
      return if $parent.is('a')
    $to = $(e.toElement)
    return if $to.is('a') || $to.data('link')?
    $a = $('<a/>', href: $element.data('link'))
    $a[0].dispatchOldEvent(new old_old_event.constructor(old_old_event.type, old_old_event))
    false
  ###