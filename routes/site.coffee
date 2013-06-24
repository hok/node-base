routes = (app) ->

  app.get '/', (req, res) ->
    res.render "../views/index",
      title: 'Node Base Home'
      stylesheet: 'site'

module.exports = routes
