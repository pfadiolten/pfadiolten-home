#= require bootstrap-fileinput/js/plugins/piexif
#= require bootstrap-fileinput/js/plugins/sortable
#= require bootstrap-fileinput/js/plugins/purify
#= require bootstrap-fileinput/js/fileinput
#= require bootstrap-fileinput/js/locales/de
#= require bootstrap-fileinput/themes/fa/theme


$ ->
  ###
  $('input[type=file]').fileinput(
    theme: 'fa'
    language: 'de'
    showUpload: false
    showClose: 'false'
  )
  ###