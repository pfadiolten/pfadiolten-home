#= require tempusdominus-bootstrap-4.js

App.onLoad ($root) ->
  $root.find('.datetime-picker, .date-picker').each query arg ($picker) ->
    $pickerInput = $picker.find('input, .input-group-append')
    inputId = $pickerInput.attr('id')
    $picker.attr('id', "#{inputId}Picker")
    $pickerInput.attr('data-target', "##{inputId}Picker")

  $root.find('.datetime-picker').datetimepicker(
    locale: 'de',
    format: 'DD.MM.YYYY - HH:mm'
  )

  $root.find('.date-picker').datetimepicker(
    locale: 'de',
    format: 'DD.MM.YYYY'
  )