#= require hermitage

noPixel = (value) ->
  if Number.isInteger(value)
    value
  else
    parseInt(value.replace(/px/, ''))

$ ->
  # editing of albums, used in /edit
  $('.editable-gallery').each query arg ($gallery) ->
    $removeInput = $gallery.find('input#deletedImages')
    ids        = $gallery.data('ids')
    removedIds = {}
    i          = 0
    $gallery.closest('form').submit (e) ->
      array = []
      for own id of removedIds
        array.push(id)
      $removeInput.val(array.join(';'))

    $gallery.find('.thumbnail').each query arg ($thumb) ->
      index = i
      i += 1

      $icon = $('<i>', class: 'fa fa-times')
      $destroyButton =
        $('<div>', class: 'btn btn-danger').append($icon)

      isDestroyed = false
      listener = ->
        width = "#{noPixel($thumb.width()) +
          noPixel($thumb.css('padding-left')) +
          noPixel($thumb.css('padding-right')) +
          noPixel($thumb.css('border-right-width')) +
          noPixel($thumb.css('border-left-width'))}px"

        height = "#{noPixel($thumb.height()) +
          noPixel($thumb.css('padding-top')) +
          noPixel($thumb.css('padding-bottom')) +
          noPixel($thumb.css('border-top-width')) +
          noPixel($thumb.css('border-bottom-width'))}px"

        $destroyButton.css(width: width, height: height, opacity: '0.7', lineHeight: "#{noPixel(height) - $icon.height()}px")

      $destroyButton.css(
        position: 'absolute'
        right: $thumb.parent().css('padding-right')
        top: $thumb.parent().css('padding-top')
      )
        .hover (e) ->
          false
        .click (e) ->
          if isDestroyed
            delete removedIds[ids[index]]
            $window.off('resize', listener)
            $destroyButton.css(width: '', height: '', opacity: '', lineHeight: '')
          else
            removedIds[ids[index]] = true
            $window.resize(listener).resize()

          isDestroyed = !isDestroyed
          $icon.toggleClass('fa-times fa-undo')
          false

      $thumb.append($destroyButton)