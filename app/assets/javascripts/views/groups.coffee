$ ->
  ###
  $switches = $('.sort-order .switch-groups')


  $switches.click query arg ($switch) ->
    $prevGroup = $switch.parent().prev('.group')
    $nextGroup = $switch.parent().next('.group')

    console.log $prevGroup, $nextGroup

    $prevContents = $prevGroup.children().detach()
    $nextContents = $nextGroup.children().detach()

    $prevGroup.append($nextContents)
    $nextGroup.append($prevContents)
    ###

