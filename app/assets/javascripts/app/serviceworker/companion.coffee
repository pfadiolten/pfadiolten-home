if navigator.serviceWorker?
  navigator.serviceWorker.register('/serviceworker.js', scope: './')
    .then (reg) ->
      console.debug '[Companion]', 'Service worker registered!'