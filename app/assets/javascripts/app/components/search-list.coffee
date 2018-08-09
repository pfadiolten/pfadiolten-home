App.components['search-list'] = ($target, selector) ->
  children =
    $elements: $target.find("#{selector}__element")
    $input:    $target.find("#{selector}__input")

  args =
    entries: children.$elements.map(-> new SearchElement($(@)))

  callbacks =
    filter: ->
      # read the query from the search input
      query = children.$input.val()

      # show the elements which match the query
      for entry in args.entries
        if entry.matches(query)
          entry.show()
        else
          entry.hide()

  # filter whenever $input changes
  children.$input
    .keyup(callbacks.filter)
    .change(callbacks.filter)


class SearchElement
  constructor: ($element) ->
    @$element = $element
    @terms =
      # Get the elements search term.
      # They are lowercased and trimmed, so they can be queried while ignoring case
      $element.data('terms').map((term) -> term.toLowerCase().trim())

  # Matches the query against the elements terms.
  # It returns true if all query parts match at least one search term.
  matches: (query) ->
    for queryPart in query.split(/\s+/)
      queryPart = escapeRegex(queryPart).toLowerCase().trim()
      matching = do (terms = @terms) ->
        index = terms.findIndex (term) ->
          term.match("^#{queryPart}") || term.match("\\s+#{queryPart}")
        index != -1
      return false unless matching
    true

  show: ->
    @$element.show()

  hide: ->
    @$element.hide()

# Escapes all regex-special chars of a string
escapeRegex = (string) ->
  string.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&')
