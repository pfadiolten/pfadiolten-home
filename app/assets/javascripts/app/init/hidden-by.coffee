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
        $hiddenParent.css(visibility: 'hidden')
      else
        $hiddenParent.css(visibility: '')

    $hideSwitch.change().change()