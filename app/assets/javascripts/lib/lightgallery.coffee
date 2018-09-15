#= require lightgallery/dist/js/lightgallery-all

App.onLoad ($root) ->
  $('.gallery:not(.gallery--no-lightbox)').lightGallery(
    thumbnail: true
    getCaptionFromTitleOrAlt: false
  )