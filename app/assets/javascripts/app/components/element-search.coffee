$ ->
  $('.search-list').each query arg ($list) ->
    entries = []
    $elements = $list.find('.search-element').each query arg ($element) ->
      entries.push([ $element, $element.data('terms').map((it) -> it.toLowerCase().trim()) ])

    searcher = query arg ($input) ->
      search = RegExp.escape($input.val().toLowerCase().trim())
      for [ $element, terms ] in entries
        do ->
          for term in terms
            if term.match("^#{search}") || term.match("\\s+#{search}")
              $element.show()
              return
          $element.hide()

    $list.find('.search-input').keyup(searcher).change(searcher)