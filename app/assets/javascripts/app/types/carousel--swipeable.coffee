App.types['.carousel.carousel--swipeable'] = ($target) ->
  callbacks =
    goBackward: ->
      $target.carousel('prev')
    goForward: ->
      $target.carousel('next')

  $target.hammer()
    .add(new Hammer.Swipe())
    .on('swiperight', callbacks.goBackward)
    .on('swipeleft', callbacks.goForward)