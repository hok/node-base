redis = require('redis').createClient()

class Item
  @key: ->
    "Item:#{process.env.NODE_ENV}"

  @states: ['approved', 'not_approved']

  @all: (callback) ->
    redis.hgetall Item.key(), (err, objects) ->
      items = []
      for id, json of objects
        item = new Item JSON.parse(json)
        items.push item
      callback null, items

  @getById: (id, callback) ->
    redis.hget Item.key(), id, (err, json) ->
      if json is null
        callback new Error("Item #{id} could not be found")
        return
      item = new Item JSON.parse(json)
      callback null, item

  @approved: (callback) ->
    Item.all (err, items) ->
      approvedItems = (item for item in items when item.state is 'approved')
      callback null, approvedItems

  constructor: (attributes) ->
    @[key] = value for key, value of attributes
    @setDefaults()

  setDefaults: ->
    unless @state
      @state = 'not_approved'
    @generateId()

  generateId: ->
    if not @id and @name
      @id = @name.replace /\s/g, '-'

  save: (callback) ->
    @generateId()
    redis.hset Item.key(), @id, JSON.stringify(@), (err, code) =>
      callback null, @

module.exports = Item
