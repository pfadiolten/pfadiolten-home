#= require ckeditor/init

App.onLoad ($root) ->
  $root.find('.text-editor').each query arg ($editor) ->
    CKEDITOR.replace $editor[0],
      language: 'de'
      toolbar: [
        {
          name: 'editing'
          items: [
            'Find',
            'RemoveFormat'
            'Maximize'
          ]
        }
        {
          name: 'clipboard'
          items: [
            'Undo', 'Redo'
          ]
        }
        {
          name: 'paragraph'
          items: [
            'NumberedList', 'BulletedList'
            '-'
            'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'
            '-'
            'Blockquote'
            '-'
            'Outdent', 'Indent'
          ]
        }
        {
          name: 'insert'
          items: [
            'Link', 'Unlink'
            '-'
            'Image', 'Table', 'HorizontalRule'
          ]
        }
        '/'
        {
          name: 'styles'
          items: [
            'Format', 'FontSize'
          ]
        }
        {
          name: 'basicstyles'
          items: [
            'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'
          ]
        }
        {
          name: 'colors',
          items: [
            'TextColor', 'BGColor'
          ]
        }
        {
          name: 'about',
          items: [ 'About' ]
        }
      ]
