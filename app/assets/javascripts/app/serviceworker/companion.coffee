if navigator.serviceWorker?
  navigator.serviceWorker.register('/serviceworker.js', scope: './')
    .then (reg) ->
      puts '[Companion]', 'Service worker registered!'