$ ->
  $('[data-mirror]').each query arg ($element) ->
    mirrorConfig = $element.data('mirror')
    $source = $(mirrorConfig.source)

    access = ($el, value) ->
      if value?
        $el.attr(mirrorConfig.destination, value)
      else
        $el.attr(mirrorConfig.destination)

    elementChanged = false
    changeHandle = ->
      value = access($element)
      if value? && value.length > 0 && value != $source.val()
        elementChanged = true
      else
        elementChanged = false

    $element
      .keyup(changeHandle)
      .change(changeHandle)

    handle = ->
      access($element, $source.val()) unless elementChanged

    $source
      .keyup(handle)
      .change(handle)
      .change()
