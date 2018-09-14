#= require sortablejs/Sortable

App.onLoad ($root) ->
  $root.find('.js-sortable').each ->
    $sortable = $(@)
    Sortable.create($sortable[0])


