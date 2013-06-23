
assert  = require 'assert'
Item = require '../../models/item'

describe 'Item', ->
  describe 'create', ->
    item = null

    before ->
      item = new Item { name: 'Base Item'}

    it 'sets name', ->
      assert.equal item.name, 'Base Item'

    it 'defaults to not approvedstate', ->
      assert.equal item.state, 'not_approved'

    it 'generates Id', ->
      assert.equal item.id, 'Base-Item'

