#= require rails-ujs

## jquery
#= require jquery3
#= require jquery-ui
#= require jquery-ui/widgets/autocomplete

## moment.js
#= require moment
#= require moment/de

## components
#= require bootstrap-datetimepicker
#= require plugins/checkbox-x

## bootsrap
#= require popper
#= require bootstrap-sprockets

## select2
#= require select2-full
#= require select2_locale_de

## tinymce
#= require tinymce-jquery

## leaflet
#= require leaflet

## lib
#= require lib

## app
#= require app/globals
#= require app/init
#= require app/components

$.extend window.App ?= {},
  ready: $(document).ready

App.ready ->