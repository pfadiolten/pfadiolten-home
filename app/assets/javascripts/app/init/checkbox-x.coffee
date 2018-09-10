App.onLoad ($root) ->
  $root.find('.checkbox input[type=checkbox]').checkboxX(
    threeState:    false
    enclosedLabel: true
    iconChecked:   '<i class="fas fa-check text-success"></i>'
    iconUnchecked: '<i class="fas fa-times text-danger"></i>'
  )