#= require rails-ujs

## leaflet
#= require leaflet

## moment.js
#= require moment
#= require moment/de

## lib
#= require lib

## components
#= require plugins/checkbox-x

## bootsrap
#= require popper
#= require bootstrap-sprockets

## select2
#= require select2-full
#= require select2_locale_de

## tinymce
#= require tinymce-jquery

## app
#= require app/globals
#= require app/init
#= require app/inputs
#= require app/components

#= require app/serviceworker/companion.coffee.erb

App.onPageLoad ->
  $('body')[0].addEventListener('touchstart', (->), passive: true)

