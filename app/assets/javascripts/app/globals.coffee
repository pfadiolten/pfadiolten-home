$.extend window,
  puts: console.log,

  $window: $(window),

  query: (callback) ->
    (args...) ->
      callback.apply($(@), args)

  arg: (callback) ->
    that = @
    (args...) ->
      args.unshift(@)
      callback.apply(that, args)