App.components['lazy-element'] = ($target) ->
  api = $target.data('url')

  puts api

  $.get(api)
    .done (data) ->
      $target.replaceWith(data)
    .fail (_jqXHR, textStatus, errorThrown) ->
      $target.replaceWith $('<div/>', class: 'alert alert-danger d-flex justify-content-center align-items-center', html: '<i class: "fe fe-alert-cirlce"></i>')
      console.error("lazy element failed to load (api: #{api}, textStatus: #{textStatus}, error: #{errorThrown})")



