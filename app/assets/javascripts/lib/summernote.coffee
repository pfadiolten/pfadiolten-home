#= require summernote/summernote-bs4
#= require summernote/lang/summernote-de-DE

App.onLoad ($root) ->
  $('.text-editor').summernote
    lang: 'de-DE'
    height: 300
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