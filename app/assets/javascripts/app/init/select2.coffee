App.onLoad ($root) ->
  $root.find('select').each query arg ($select) ->
    $select.select2(
      theme:    'bootstrap4'
      language: 'de'
      width:    '100%'
    )

    name = $select.attr('name')
    $("input[name='#{name}'").detach()