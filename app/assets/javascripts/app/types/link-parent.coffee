App.types['.link-parent'] = ($target) ->
  args =
    url: $target.data('url')

  $target.children('*:not(.link-parent__ignore)').wrap(
    $('<a>', href: args.url, class: 'unstyle')
  )