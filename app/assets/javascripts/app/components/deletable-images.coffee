App.components['deletable-images'] = ($target, selector) ->
  args =
    destroyIcon: $target.data('destroy-icon')
    removedIds: {}

  callbacks =
    destroy: (image) ->
      args.removedIds[image.getId()] = true
    restore: (image) ->
      delete args.removedIds[image.getId()]

  children =
    $input:  $target.find("#{selector}__input")
    $images: $target.find('img[data-id]')

  children.$images.each query arg ($image) ->
    destroyButton = new DestroyButton(icon: args.destroyIcon)
    image         = new Image($image, { destroyButton: destroyButton, destroy: callbacks.destroy, restore: callbacks.restore })


  $target.closest('form').submit (e) ->
    array = []
    for own id of args.removedIds
      array.push(id)
    children.$input.val(array.join(';'))

class Image
  constructor: (@$element, { @destroyButton, destroy, restore }) ->
    @$element.after(@destroyButton.getElement())
    @destroyButton.onDestroy(=> destroy(@))
    @destroyButton.onRestore(=> restore(@))

  getElement: ->
    @$element

  getId: ->
    @$element.data('id')

class DestroyButton
  constructor: ({ icon }) ->
    @$icon       = $(icon)
    @isDestroyed = false
    @callbacks =
        destroy: []
        restore: []

    btnStyle =
      position:          'absolute'
      right:             0
      top:               0
      display:           'flex'
      'align-items':     'center'
      'justify-content': 'center'

    @$button = $('<div>', class: 'btn btn-danger')
      .append(@$icon)
      .css(btnStyle)
      .hover(-> false)
      .click(@toggle.bind(@))

    @resizeDestroyed = @resizeDestroyed.bind(@)

  getElement: ($img) ->
    @$button

  toggle: ->
    if @isDestroyed
      @restore()
    else
      @destroy()
    @$icon.toggleClass('fa-times fa-undo')
    @isDestroyed = !@isDestroyed
    false

  onDestroy: (callback) ->
    @callbacks.destroy.push(callback)

  onRestore: (callback) ->
    @callbacks.restore.push(callback)

  destroy: ->
    $window.resize(@resizeDestroyed).resize()
    callback() for callback in @callbacks.destroy

  restore: ->
    $window.off('resize', @resizeDestroyed)
    @$button.css(width: '', height: '', opacity: '')
    callback() for callback in @callbacks.restore


  resizeDestroyed: ->
    @$button.css(
      width:   @$button.parent().width()
      height:  @$button.parent().height()
      opacity: '0.7'
    )