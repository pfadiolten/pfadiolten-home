$ ->
  $('.checkbox input[type=checkbox]').checkboxX(
    threeState:    false
    enclosedLabel: true
    iconChecked:   '<i class="fa fa-check text-success"></i>'
    iconUnchecked: '<i class="fa fa-times text-danger"></i>'
  )

  $('.datetime-picker').datetimepicker(
    locale: 'de',
    format: 'DD.MM.YYYY - HH:mm'
  )

  $('select').each query arg ($select) ->
    $select.select2(
      theme:    'bootstrap',
      language: 'de'
    )
    name = $select.attr('name')
    $("input[name='#{name}'").detach()