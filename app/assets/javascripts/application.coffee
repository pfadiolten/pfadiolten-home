#= require rails-ujs

## lib
#= require lib

## components
#= require plugins/checkbox-x

## app
#= require app/globals
#= require app/init
#= require app/inputs
#= require app/components
#= require app/types

#= require app/serviceworker/companion.coffee.erb

App.onPageLoad ->
  $('body')[0].addEventListener('touchstart', (->), passive: true)

