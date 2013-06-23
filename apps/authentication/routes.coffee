routes = (app) ->

  app.get '/login', (req, res) ->
    res.render "#{__dirname}/views/login",
      title: 'Login'
      stylesheet: 'login'

  app.post '/sessions', (req, res) ->
    if ('username' is req.body.user) and ('password' is req.body.password)
      req.session.currentUser = req.body.user
      req.flash 'info', "You are logged in as #{req.session.currentUser}"

      if req.session.location
        res.redirect req.session.location
      else
        res.redirect '/login'
      return

    req.flash 'error', 'Invalid credentials'
    res.redirect '/login'

  app.del '/sessions', (req, res) ->
    req.session.regenerate (err) ->
      req.flash 'info', 'You have been logged out'
      res.redirect '/login'

module.exports = routes
