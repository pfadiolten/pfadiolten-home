#= require_self
#= require app/components/search-list
#= require app/components/toggleable
#= require app/components/link
#= require app/components/expandable
#= require app/components/mirror
#= require app/components/deletable-images

App.components = {}

App.onLoad ($root) ->
  for componentName, initialize of App.components
    selector = ".js-#{componentName}"
    $root.find(selector).each query arg ($target) ->
      initialize($target, selector)