#= require lightgallery/dist/js/lightgallery-all

App.onLoad ($root) ->
  $('.gallery').lightGallery(
    thumbnail: true
    getCaptionFromTitleOrAlt: false
  )