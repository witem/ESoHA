debug         = require('debug')('ESoHA')
express       = require('express')
path          = require('path')
favicon       = require('serve-favicon')
logger        = require('morgan')
cookieParser  = require('cookie-parser')
bodyParser    = require('body-parser')
ECT           = require 'ect'
connectCoffeescript  = require 'connect-coffee-script'
coffeeScript  = require 'coffee-script'

routes        = require('./routes/index')
users         = require('./routes/users')

app = express()

# view engine setup
ectRenderer = ECT
  watch: true
  root: __dirname + '/views'
  ext : '.ect'
app.set 'view engine', 'ect'
app.engine 'ect', ectRenderer.render

app.use favicon(__dirname + '/public/favicon.ico')
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: false })
app.use cookieParser()
console.log path.join(__dirname, 'public_coffee')
app.use(connectCoffeescript
    src: path.join(__dirname, 'public_coffee')
    dest: path.join(__dirname, 'public')
    compile: (str, options, coffeePath)->
      options.bare = true
      return coffeeScript.compile(str, options)
)
app.use express.static(path.join(__dirname, 'public'))

app.use '/', routes
app.use '/room-*', users

# catch 404 and forward to error handler
app.use (req, res, next)->
  err = new Error('Not Found')
  err.status = 404
  next(err)

# error handlers

# development error handler
# will print stacktrace
if app.get('env') == 'development'
  app.use (err, req, res, next)->
    res.status err.status || 500
    res.render 'error',
      message: err.message
      error: err


# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next)->
  res.status err.status || 500
  res.render 'error',
    message: err.message
    error: {}

app.set 'port', process.env.PORT || 1337

server = app.listen app.get('port'), ()->
  debug "Express server listening on port #{server.address().port}"

module.exports = app
