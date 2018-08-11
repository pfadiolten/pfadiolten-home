App.components['lazy-element'] = ($target) ->
  api = $target.data('url')
  $.get(api)
    .done (data) ->
      $data = $(data)
      App.register($data)
      $target.replaceWith($data)
    .fail (_jqXHR, textStatus, errorThrown) ->
      $target.replaceWith $('<div/>', class: 'alert alert-warning d-flex justify-content-center align-items-center w-100', html: '<i class="fe fe-alert-circle"></i>')
      console.error("lazy element failed to load (api: #{api}, textStatus: #{textStatus}, error: #{errorThrown})")



