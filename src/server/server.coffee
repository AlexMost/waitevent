path = require 'path'

express = require 'express'
passport = require 'passport'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
session = require 'express-session'
RedisStore = (require 'connect-redis')(session)
expressValidator = require 'express-validator'

{init_db} = require './db'
{init_auth, is_logged_in} = require './auth'
{get_config} = require './config'

{create_event_post, create_event_get,
edit_event_get, edit_event_post,
delete_event, event_view_get} = require './handlers/event'

{welcome_page_get} = require './handlers/welcome_page'
{my_events_get} = require './handlers/events_list'

UserEvent = require './models/userEvent'
config = get_config()

app = express()
app.set 'views', __dirname
app.set 'view engine', 'ejs'
app.use express.static(path.resolve __dirname, '../../public')
app.use express.static(path.resolve __dirname, '../../image')
app.use cookieParser()
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use expressValidator()

app.use session
    secret: "redis_session_secret"
    store: new RedisStore
        host: config.redis_host
        port: config.redis_port

app.use passport.initialize()
app.use passport.session()

init_db config.db_path
init_auth()

app.get '/', welcome_page_get

app.get '/event/:eventId',  event_view_get

app.get '/create_event', is_logged_in, create_event_get
app.post '/create_event', is_logged_in, create_event_post

app.get '/edit_event/:eventId', is_logged_in, edit_event_get
app.post '/edit_event/:eventId', is_logged_in, edit_event_post

app.post '/delete_event/:eventId', is_logged_in, delete_event

app.get '/my_events', is_logged_in, my_events_get

app.get('/auth/google',
    (req, res, next) ->
        req.session.redirect = req.query.r
        next()
    passport.authenticate('google'))

app.get(
    '/auth/google/return'
    passport.authenticate('google')
    (req, res) ->
        res.redirect req.session.redirect or "back"
        delete req.session.redirect)

server = app.listen(3000, -> console.log 'Listening port 3000')
