#= require summernote/summernote-bs4
#= require summernote/lang/summernote-de-DE

App.onLoad ($root) ->
  $('.text-editor').summernote
    lang: 'de-DE'
    height: 200
    defaultFontName: 'Encode Sans Expanded'
    toolbar: [
      [
        'misc'
        [ 'fullscreen', 'undo', 'redo', 'clear', 'help' ]
      ]
      [
        'style'
        [ 'style', 'color'  ]
      ]
      [
        'font'
        [ 'bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript' ]
      ]
      [
        'insert'
        [ 'table', 'link', 'picture', 'video', 'hr' ]
      ]
      [
        'paragraph'
        [ 'ol', 'ul', 'paragraph' ]
      ]
    ]
    callbacks:
      onPaste: (e) ->
        bufferText = ((e.originalEvent || e).clipboardData || window.clipboardData).getData('Text')
        e.preventDefault()
        document.execCommand('insertText', false, bufferText);