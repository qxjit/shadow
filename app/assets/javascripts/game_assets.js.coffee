# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.GameAsset extends Backbone.Model

window.GameAssets = new (Backbone.Collection.extend
  model: GameAsset
  url: '/game_assets'
)

class window.GameAssetList extends Backbone.View
  tagName: 'table'

  render: ->
    $(this.el).html(JST['templates/game_asset_list'](character: this.model))
    this.renderAsset asset for asset in this.model.gameAssets()
    this

  renderAsset: (asset) ->
    view = new GameAssetView model: asset
    this.$('tbody').append view.render().el

class window.GameAssetView extends Backbone.View
  tagName: 'tr'

  events:
    'change input.equipped': 'updateEquipped'

  initialize: ->
    this.model.on 'change', this.render

  render: =>
    $(this.el).html(JST['templates/game_asset'](
      game_asset: this.model
    ))
    this

  updateEquipped: ->
    checkbox = this.$ 'input.equipped'
    this.model.save equipped: checkbox.prop('checked')

