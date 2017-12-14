
$ ->
  $('.file_handle').each query arg ($handle) ->
    $inputs = $handle.find('.inputs')
    $buttons = $handle.find('.buttons')

    $attrInput = $inputs.find('.attribute')
    $attrButton = $buttons.find('.attribute')

    attrText = $attrButton.text()
    $fileElements = null
    $attrInput.change ->
      fileList = $attrInput.prop('files')
      files = $.map(fileList, (f) -> f.name)

      if files.length == 0
        $attrButton.text(attrText)
      else
        $attrButton.text("#{attrText} (#{if files.length == 1 then files[0] else "#{files.length}"})")

    $attrButton.click ->
      $attrInput.click()

    $destroyInput = $inputs.find('._destroy')
    $destroyButton = $buttons.find('._destroy')

    $backupIcon = $('<i>', class: 'fa fa-undo')
    $destroyButton.click ->
      if $destroyInput.is(':checked')
        $destroyInput.click()
        $attrButton.show()
        $destroyButton.removeClass('col-xs-12').addClass('col-xs-4')
        $attrInput.val('').change()
      else
        $destroyInput.click()
        $attrButton.hide()
        $destroyButton.removeClass('col-xs-4').addClass('col-xs-12')

      $current = $destroyButton.find('i').detach()
      $destroyButton.append($backupIcon)
      $backupIcon = $current