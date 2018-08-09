App.components['toggleable'] = ($target) ->
  args =
    togglerSelector: $target.data('toggler')
    onClass:  $target.data('toggle-on')
    offClass: $target.data('toggle-off')

  children =
    $toggler: $(args.togglerSelector)

  callbacks =
    toggle: ->
      $target.toggleClass("#{args.onClass} #{args.offClass}")

  children.$toggler
    .change(callbacks.toggle)