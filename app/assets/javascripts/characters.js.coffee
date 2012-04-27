# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class window.Character extends Backbone.Model
  gameAssets: ->
    GameAssets.where character_id: this.id

window.Characters = new (Backbone.Collection.extend
  model: Character
  url: '/characters'
)

class window.CharacterList extends Backbone.View
  tagName: 'div'

  initialize: ->
    Characters.bind 'add', this.add, this
    Characters.bind 'reset', this.reset, this

    $(this.el).html(JST['templates/character_list']())

  add: (character) ->
    view = new CharacterView model: character
    this.$('#characters').append view.render().el
    this

  reset: ->
    Characters.each this.add

class window.CharacterView extends Backbone.View
  tagName: 'li'

  events:
    click: 'showDetail'

  render: ->
    $(this.el).html(JST['templates/character'](character: this.model))
    this

  showDetail: =>
    detailView = new CharacterDetailView model: this.model
    $('#detail').html(detailView.render().el)

class window.CharacterDetailView extends Backbone.View
  tagName: 'div'

  render: ->
    $(this.el).html(JST['templates/character_detail'](character: this.model))

    asset_list = new GameAssetList model: this.model

    this.$('.game-assets').append asset_list.render().el
    this


