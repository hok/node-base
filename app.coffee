require('coffee-script')

express = require('express')
http    = require('http')
path    = require('path')
flash   = require('connect-flash')

RedisStore = require('connect-redis')(express)
require('express-namespace')
app     = express()

# all environments
app.set('port', process.env.PORT || 3000)
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')
app.use(express.favicon())
app.use(express.logger('dev'))
app.use(express.bodyParser())
app.use(express.methodOverride())
app.use(express.cookieParser())

# Remember to change the following
app.use(express.session({
  secret: "aaaaaaaaaa",
  store: new RedisStore
}))

# Enable flash messages
app.use(flash())

# Use Rails style asset pipeline
app.use(require('connect-assets')())
app.use(app.router)
app.use(express.static(path.join(__dirname, 'public')))

# development only
if 'development' is app.get('env')
  app.use(express.errorHandler())

# helpers
require('./apps/helpers')(app)
require('./middleware/upgrade')(app)

# routes
require('./routes/site')(app)
require('./apps/authentication/routes')(app)

server = app.listen(app.settings.port)
console.log("Express server listening on port %d in %s mode", app.settings.port, app.settings.env)

# Uncomment to enable Socket.io
# io = require('socket.io').listen(server)
