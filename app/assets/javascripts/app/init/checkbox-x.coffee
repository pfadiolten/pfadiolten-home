App.onLoad ($root) ->
  $root.find('.checkbox input[type=checkbox]').checkboxX(
    threeState:    false
    enclosedLabel: true
    iconChecked:   '<i class="fe fe-check text-success"></i>'
    iconUnchecked: '<i class="fe fe-x text-danger"></i>'
  )