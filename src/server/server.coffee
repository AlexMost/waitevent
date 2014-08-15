path = require 'path'
express = require 'express'
passport = require 'passport'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
session = require 'express-session'

{init_db} = require './db'
{init_auth, is_logged_in} = require './auth'
WelcomePage = require '../components/welcome_page'
CreateEventPage = require '../components/create_event_page'
{reactRender} = require './react_render'


app = express()
app.set 'views', __dirname
app.set 'view engine', 'ejs'
app.use express.static(path.join __dirname, 'public')
app.use cookieParser()
app.use bodyParser()
app.use session {secret: "session secret"}
app.use passport.initialize()
app.use passport.session()


init_db 'mongodb://33.33.33.10/waitevent'
init_auth()


app.get '/', (req, res) ->

    reactRender(
        res
        WelcomePage
        {user: req.user}
        {initScript: '/js/welcome_page.js'}
    )


app.get(
    '/create_event',
    # is_logged_in,
    (req, res) ->
        reactRender(
            res
            CreateEventPage
            {user: req.user}
            {initScript: '/js/create_event_page.js'}
        )
)


app.get('/auth/google',
    (req, res, next) ->
        console.log "storing #{req.query.r}"
        req.session.redirect = req.query.r
        next()
    passport.authenticate('google')
)


app.get(
    '/auth/google/return'
    passport.authenticate('google')
    (req, res) ->
        res.redirect req.session.redirect or "back"
        delete req.session.redirect
)


server = app.listen(3000, -> console.log 'Listening port 3000')
