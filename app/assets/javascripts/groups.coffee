$ ->
  $switches = $('.sort-order .switch-groups')

  $switches.click query arg ($switch) ->
    $prevGroup = $switch.prev('.group')
    $nextGroup = $switch.next('.group')

    $prevContents = $prevGroup.children().detach()
    $nextContents = $nextGroup.children().detach()

    $prevGroup.append($nextContents)
    $nextGroup.append($prevContents)

