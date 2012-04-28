describe "GameAsset", ->
  describe "total", ->
    it "is product of price and amount", ->
      asset = new GameAsset price: 2, amount: 4
      expect(asset.total()).toBe 8

    it "handles nulls", ->
      asset = new GameAsset amount: 4
      expect(asset.total()).toBe undefined

      asset = new GameAsset price: 2
      expect(asset.total()).toBe undefined

