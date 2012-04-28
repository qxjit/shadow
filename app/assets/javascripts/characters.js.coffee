#=require view

class window.Character extends Backbone.Model
  assets: ->
    GameAsset.collection.where character_id: this.id

  assetTotal: ->
    _.foldl this.assets(),
            (total, asset) -> total + asset.total(),
            0
  expenses: ->
    GameExpense.collection.where character_id: this.id

  expenseTotal: ->
    _.foldl this.expenses(),
            (total, expense) -> total + expense.total(),
            0

  equippedAssets: ->
     _.filter this.assets(), (a) -> a.get "equipped"

  legalStatus: ->
     _.foldl this.equippedAssets(),
             ((legality, asset) ->
               assetLegality = asset.get "legality"

               if legality == "Public"
                 assetLegality
               else if assetLegality == "Forbidden"
                 "Forbidden"
               else
                 legality),

             "Public"

Character.collection = new (Backbone.Collection.extend(
  model: Character))

View.Character = {}

class View.Character.Index extends Backbone.View
  initialize: ->
    this.render()

  render: ->
    this.$el.html renderTemplate('characters/index',
                                 characters: Character.collection.models)
    $('body').html(this.$el)


