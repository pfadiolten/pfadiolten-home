App.components['expandable'] = ($target, selector) ->
  args =
    minHeight: '10rem'

  children =
    $text:     $target.find("#{selector}__text")
    $showMore: $target.find("#{selector}__show-more")
    $showLess: $target.find("#{selector}__show-less")

  children.$togglers = children.$showMore.add(children.$showLess)

  callbacks =
    showMore: ->
      # animate $text to full size
      children.$text.animate(height: children.$text[0].scrollHeight, ->
        $(@).css(height: '')
      )

      # show $showLess and hide $showMore
      children.$togglers.toggle()

    showLess: ->
      # animate $text to minimal size
      children.$text.animate(height: args.minHeight)

      # show $showMore and hide $showLess
      children.$togglers.toggle()


  # register callbacks
  children.$showMore
    .click(callbacks.showMore)

  children.$showLess
    .click(callbacks.showLess)


  # set initial state
  children.$showLess.hide()

  children.$text
    .css(overflow: 'hidden', height: args.minHeight)