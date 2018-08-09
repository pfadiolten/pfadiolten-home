App.components['mirror'] = ($target) ->
  args =
    sourceSelector: $target.data('mirror-of')
    attribute: $target.data('mirror-attribute') ? 'value'
    targetHasOwnValue: false

  children =
    $source: $(args.sourceSelector)

  callbacks =
    mirror: ->
      # don't change if $target contains its own value
      return if args.targetHasOwnValue

      $target.prop(args.attribute, children.$source.val())

    updateTargetHasOwnValue: ->
      value = $target.prop(args.attribute)
      args.targetHasOwnValue =
        value? && value.length > 0 && value != children.$source.val()

  $target
    .keyup(callbacks.updateTargetHasOwnValue)
    .change(callbacks.updateTargetHasOwnValue)

  children.$source
    .keyup(callbacks.mirror)
    .change(callbacks.mirror)
    .change()
