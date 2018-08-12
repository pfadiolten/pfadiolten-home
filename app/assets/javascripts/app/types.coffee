#= require_self
#= require app/types/carousel--swipeable

App.types = {}
App.onLoad ($root) ->
  for selector, initialize of App.types
    $root.find(selector).each query arg ($target) ->
      initialize($target)