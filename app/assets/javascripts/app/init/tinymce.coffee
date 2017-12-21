$ ->

  fonts = 'Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats'

  tinyMCE.init(
    menubar:                false,
    selector:               '.text-editor'
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
      'emoticons'
    ]
    toolbar: [
      'fontselect fontsizeselect | bold italic underline | forecolor backcolor'
      ' styleselect | undo redo |styleselect | outdent indent | table numlist bullist | emoticons'
    ]

    toolbar_align : "right"

    setup: (ed) ->
      ed.on 'init', ->
        style = @getDoc().body.style
        style.fontFamily = 'encode sans expanded'
        style.textAlign  = 'center'
  )
