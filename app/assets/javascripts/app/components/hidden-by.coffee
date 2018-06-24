$ ->
  $('[data-hidden-by]').each query arg ($hiddenElement) ->
    hiddenIn = $hiddenElement.data('hidden-in')
    $hiddenParent =
      if hiddenIn?
        $hiddenElement.closest(hiddenIn)
      else
        $hiddenElement

    $hideSwitch = $($hiddenElement.data('hidden-by'))
    $hideSwitch.change ->
      if $hideSwitch.val() == "0"
        $hiddenParent.css(display: 'none')
      else
        $hiddenParent.css(display: '')

    $hideSwitch.change().change()