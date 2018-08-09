#= require_self
#= require 'app/inputs/filehandle'
App.inputs = {}

App.onLoad ($root) ->
  for inputSelector, initialize of App.inputs
    $root.find(inputSelector).each query arg ($target) ->
      initialize($target)