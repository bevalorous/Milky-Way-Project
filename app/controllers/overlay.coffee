Controller = require 'zooniverse/controllers/base-controller'
$ = window.jQuery

ESC = 27

class Overlay extends Controller
  from: 'top'
  content: ''
  associated: null

  className: 'overlay'
  template: require '../views/overlay'

  hidden: true

  constructor: ->
    super
    @el.addClass @constructor::className
    @el.addClass "from-#{@from}"
    @associated = $(@associated)

    @hide() if @hidden
    @el.prependTo document.body

  onHashChange: =>
    setTimeout (=> @hide()), 250

  onKeyDown: (e) =>
    if e.which is ESC
      @hide()

  toggle: ->
    if @hidden then @show() else @hide()

  show: ->
    @el.toggleClass 'hidden', false
    $(@associated).toggleClass 'showing-overlay', true
    @hidden = false
    addEventListener 'hashchange', @onHashChange, false
    addEventListener 'keydown', @onKeyDown, false

  hide: ->
    @el.toggleClass 'hidden', true
    $(@associated).toggleClass 'showing-overlay', false
    @hidden = true
    removeEventListener 'hashchange', @onHashChange, false
    removeEventListener 'keydown', @onKeyDown, false

module.exports = Overlay
