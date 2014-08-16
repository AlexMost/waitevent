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
WelcomePage = require '../components/welcome_page'
CreateEventPage = require '../components/create_event_page'
{reactRender} = require './react_render'
{get_config} = require './config'
UserEvent = require './models/userEvent'
config = get_config()


app = express()
app.set 'views', __dirname
app.set 'view engine', 'ejs'
app.use express.static(path.resolve __dirname, '../../public')
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


app.get '/', (req, res) ->
    reactRender(
        res
        WelcomePage
        {user: req.user}
        {initScript: '/js/welcome_page.js'}
    )


app.get(
    "/event/:eventId"
    is_logged_in
    (req, res) ->
        UserEvent.findOne {_id: req.params.eventId}, (err, event) ->
            res.json(event)
)


app.get(
    '/create_event',
    is_logged_in,
    (req, res) ->
        reactRender(
            res
            CreateEventPage
            {user: req.user}
            {initScript: '/js/create_event_page.js'}
        )
)

app.post(
    '/create_event',
    is_logged_in,
    (req, res) ->

        req.checkBody('title', "Title param is required").notEmpty()
        req.checkBody(
            'deadline',
            "Select events date and time").isDate()
        errors = req.validationErrors(true)

        if errors
            reactRender(
                res
                CreateEventPage
                {
                    user: req.user
                    errors: errors or {}
                    formData: req.body
                }
                {initScript: '/js/create_event_page.js'}
            )
        else
            newEvent = new UserEvent(
                title: req.body.title
                description: req.body.description
                deadLine: req.body.deadline
                userId: req.user._id
            )

            newEvent.save (err, event) ->
                # TODO: handle error
                res.redirect "/event/#{event._id}"
)


app.get('/auth/google',
    (req, res, next) ->
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
