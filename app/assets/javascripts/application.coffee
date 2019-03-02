#= require rails-ujs

## lib
#= require lib

## app
#= require app/globals
#= require app/inputs
#= require app/components
#= require app/types

#= require app/serviceworker/companion.coffee.erb

App.onPageLoad ->
  $('body')[0].addEventListener('touchstart', (->), passive: true)