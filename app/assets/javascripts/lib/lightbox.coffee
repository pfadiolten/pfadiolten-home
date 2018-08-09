#= require lightbox-bootstrap

$(document).delegate '*[data-toggle="lightbox"]', 'click', (event) ->
  event.preventDefault()
  $(this).ekkoLightbox()
  $('.ekko-lightbox').find('.modal-dialog').addClass('modal-dialog-centered')
  return


noPixel = (value) ->
  if Number.isInteger(value)
    value
  else
    parseInt(value.replace(/px/, ''))

App.onLoad ($root) ->
# editing of albums, used in /edit
  $root.find('.editable-gallery').each query arg ($gallery) ->
    $removeInput = $gallery.find('input#deletedImages')
    ids          = $gallery.data('ids')
    removedIds   = {}
    i            = 0
    $gallery.closest('form').submit (e) ->
      array = []
      for own id of removedIds
        array.push(id)
      $removeInput.val(array.join(';'))

    $gallery.find('[data-toggle="lightbox"]').each query arg ($thumb) ->
      $img = $thumb.find('img')

      index = i
      i += 1

      $icon = $('<i>', class: 'fe fe-x')
      $destroyButton =
        $('<div>', class: 'btn btn-danger').append($icon)

      isDestroyed = false
      listener = ->
        width = "#{noPixel($img.width()) +
          noPixel($img.css('padding-left')) +
          noPixel($img.css('padding-right')) +
          noPixel($img.css('border-right-width')) +
          noPixel($img.css('border-left-width'))}px"

        height = "#{noPixel($img.height()) +
          noPixel($img.css('padding-top')) +
          noPixel($img.css('padding-bottom')) +
          noPixel($img.css('border-top-width')) +
          noPixel($img.css('border-bottom-width'))}px"

        $destroyButton.css(width: width, height: height, opacity: '0.7', lineHeight: "#{noPixel(height) - $icon.height()}px")

      $destroyButton.css(
        position: 'absolute'
        right:    $thumb.parent().css('padding-right')
        top:      $thumb.parent().css('padding-top')
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
          $icon.toggleClass('fe-x fe-repeat')
          false

      $thumb.append($destroyButton)