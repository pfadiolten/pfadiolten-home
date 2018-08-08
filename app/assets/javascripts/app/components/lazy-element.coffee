$ ->
  $('.js-lazy-element').each query arg ($element) ->
    api = $element.data('url')
    $.get(api)
      .done (data) ->
        $element.replaceWith(data)
      .fail (_jqXHR, textStatus, errorThrown) ->
        $element.replaceWith $('<div/>', class: 'alert alert-danger d-flex justify-content-center align-items-center', html: '<i class: "fe fe-alert-cirlce"></i>')
        console.error("lazy element failed to load (api: #{api}, textStatus: #{textStatus}, error: #{errorThrown})")



