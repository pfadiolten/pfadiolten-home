#= require photoswipe

makeOptions = ($target) ->

App.onPageLoad ->
  $(body).append(photoswipe)

App.onLoad ($root) ->
  pswp = $('.pswp')[0]
  $root.find('.gallery').each query arg ($target) ->
    images = $target.find('.gallery__image').map(($it) -> $it.data('src')).get()
    gallery = new PhotoSwipe(
      pswp
      PhotoSwipeUI_Default
      images
      makeOptions($target)
    )


photoswipe = '''
<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">

  <!-- Background of PhotoSwipe.
       It`s a separate element as animating opacity is faster than rgba(). -->
  <div class="pswp__bg"></div>

  <!-- Slides wrapper with overflow:hidden. -->
  <div class="pswp__scroll-wrap">

    <!-- Container that holds slides.
        PhotoSwipe keeps only 3 of them in the DOM to save memory.
        Don`t modify these 3 pswp__item elements, data is added later on. -->
    <div class="pswp__container">
      <div class="pswp__item"></div>
      <div class="pswp__item"></div>
      <div class="pswp__item"></div>
    </div>

    <!-- Default (PhotoSwipeUI_Default) interface on top of sliding area. Can be changed. -->
    <div class="pswp__ui pswp__ui--hidden">

      <div class="pswp__top-bar">

        <!--  Controls are self-explanatory. Order can be changed. -->

        <div class="pswp__counter"></div>

        <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>

        <button class="pswp__button pswp__button--share" title="Share"></button>

        <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>

        <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>

        <!-- Preloader demo http://codepen.io/dimsemenov/pen/yyBWoR -->
        <!-- element will get class pswp__preloader--active when preloader is running -->
        <div class="pswp__preloader">
          <div class="pswp__preloader__icn">
            <div class="pswp__preloader__cut">
              <div class="pswp__preloader__donut"></div>
            </div>
          </div>
        </div>
      </div>

      <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
        <div class="pswp__share-tooltip"></div>
      </div>

      <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
      </button>

      <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
      </button>

      <div class="pswp__caption">
        <div class="pswp__caption__center"></div>
      </div>
    </div>
  </div>
</div>
'''


###
$(document).delegate '*[data-toggle="lightbox"]', 'click', (event) ->
  event.preventDefault()

  $(@).ekkoLightbox(
    onShown: (args...) ->
      $dialog = @_$modalDialog
      $dialog.css(
        display: 'flex'
        color: 'red'
      )
  )
  $('.ekko-lightbox').find('.modal-dialog').addClass('modal-dialog-centered')
  return


noPixel = (value) ->
  if Number.isInteger(value)
    value
  else
    parseInt(value.replace(/px/, ''))

App.onLoad ($root) ->
# editing of albums, used in /edit
  $root.find('.editable-gallery').each query arg ($gallery) ->
    $removeInput = $gallery.find('input#deletedImages')
    ids          = $gallery.data('ids')
    removedIds   = {}
    i            = 0
    $gallery.closest('form').submit (e) ->
      array = []
      for own id of removedIds
        array.push(id)
      $removeInput.val(array.join(';'))

    $gallery.find('[data-toggle="lightbox"]').each query arg ($thumb) ->
      $img = $thumb.find('img')

      index = i
      i += 1

      $icon = $('<i>', class: 'fas fa-times')
      $destroyButton =
        $('<div>', class: 'btn btn-danger').append($icon)

      isDestroyed = false
      listener = ->
        width = "#{noPixel($img.width()) +
          noPixel($img.css('padding-left')) +
          noPixel($img.css('padding-right')) +
          noPixel($img.css('border-right-width')) +
          noPixel($img.css('border-left-width'))}px"

        height = "#{noPixel($img.height()) +
          noPixel($img.css('padding-top')) +
          noPixel($img.css('padding-bottom')) +
          noPixel($img.css('border-top-width')) +
          noPixel($img.css('border-bottom-width'))}px"

        $destroyButton.css(width: width, height: height, opacity: '0.7', lineHeight: "#{noPixel(height) - $icon.height()}px")

      $destroyButton.css(
        position: 'absolute'
        right:    $thumb.parent().css('padding-right')
        top:      $thumb.parent().css('padding-top')
      )
        .hover (e) ->
          false
        .click (e) ->
          if isDestroyed
            delete removedIds[ids[index]]
            $window.off('resize', listener)
            $destroyButton.css(width: '', height: '', opacity: '', lineHeight: '')
          else
            removedIds[ids[index]] = true
            $window.resize(listener).resize()

          isDestroyed = !isDestroyed
          $icon.toggleClass('fe-x fe-repeat')
          false

      $thumb.append($destroyButton)
###