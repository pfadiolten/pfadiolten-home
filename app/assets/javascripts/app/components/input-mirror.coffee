$ ->
  $('[data-mirrors]').each query arg ($element) ->
    $source = $($element.data('mirrors'))

    elementChanged = false
    changeHandle =
      ->
        value = $element.val()
        if value? && value.length > 0 && value != $source.value
          elementChanged = true
        else
          elementChanged = false

    $element
      .keyup(changeHandle)
      .change(changeHandle)

    handle = ->
      $element.val($source.val()) unless elementChanged

    $source
      .keyup(handle)
      .change(handle)
      .change()
