class window.AppView extends Backbone.View
  tagName: "div"

  initialize: ->
    $('body').append(this.el);
    this.render()
    Characters.fetch()
    GameAssets.fetch()

  render: ->
    $(this.el).html(JST['templates/app_view']())
    this.$('#nav').append new CharacterList().el
    this.$('.main').append new AjaxIndicator().el


class window.AjaxIndicator extends Backbone.View
  tagName: "div"
  id: "ajax-indicator"
  queriesRunning: 0

  initialize: ->
    jQuery.ajaxSetup
      beforeSend: this.ajaxStart
      complete: this.ajaxStop

  ajaxStart: =>
    this.queriesRunning++

    if this.queriesRunning == 1
      this.$el.addClass 'ajax-running'
      this.$el.text "Syncing..."

  ajaxStop: =>
    if this.queriesRunning > 0
      this.queriesRunning--

    setTimeout this.removeAjaxRunning, 500

  removeAjaxRunning: =>
    if this.queriesRunning == 0
      this.$el.removeClass 'ajax-running'
      this.$el.text ''

