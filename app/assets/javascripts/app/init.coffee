#= require_self
#= require app/init/checkbox-x
#= require app/init/select2
#= require app/init/tinymce

$.extend window.App ?= {},
  onPageLoad: $(document).ready

  onLoad: (callback) ->
    App.onPageLoad ->
      callback($(document))

    App.register.callbacks.push(callback)

  register: ($element) ->
    for callback in App.register.callbacks
      callback($element)

App.register.callbacks = []