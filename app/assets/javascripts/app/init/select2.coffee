$ ->
  $('select').each query arg ($select) ->
    $select.select2(
      theme:    'bootstrap4',
      language: 'de'
    )

    name = $select.attr('name')
    $("input[name='#{name}'").detach()