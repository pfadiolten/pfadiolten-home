App.onPageLoad ->
  # fonts = 'Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats'
  fonts = ''

  tinyMCE.init(
    menubar:                false,
    selector:               ".text-editor"
    language:               'de',
    contextmenu:            'forecolor backcolor bold italic underline'
    font_formats:           'Encode Sans Expanded=encode sans expanded;' + fonts
    skin:                   'lightgray'
    convert_fonts_to_spans: true

    content_css: [
      '//fonts.googleapis.com/css?family=Encode+Sans+Expanded'
    ]
    plugins: [
      'autolink'
      'lists'
      'advlist'
      'textcolor'
      'colorpicker'
      'table'
      'contextmenu'
      'paste'
      'link'
    ]
    toolbar: [
      'undo redo | styleselect | bold italic underline | forecolor backcolor | link | outdent indent | alignleft aligncenter alignright alignjustify | numlist bullist table'
    ]
    font_formats: 'Encode Sans Expanded=encode sans expanded;' + fonts

    toolbar_align : 'right'

    mode : "textareas"
    force_br_newlines : false
    force_p_newlines : false
    forced_root_block : ''

    paste_auto_cleanup_on_paste : true
    paste_remove_styles: true
    paste_remove_styles_if_webkit: true
    paste_strip_class_attributes: true

    setup: (ed) ->
      ed.on 'init', ->
        style = @getDoc().body.style
        style.fontFamily = 'encode sans expanded'
        style.textAlign  = 'left'
  )
