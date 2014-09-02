var RedisStore, UserEvent, app, bodyParser, config, cookieParser, create_event_get, create_event_post, delete_event, edit_event_get, edit_event_post, event_view_get, express, expressValidator, get_config, init_auth, init_db, is_logged_in, my_events_get, passport, path, server, session, welcome_page_get, _ref, _ref1;

path = require('path');

express = require('express');

passport = require('passport');

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

session = require('express-session');

RedisStore = (require('connect-redis'))(session);

expressValidator = require('express-validator');

init_db = require('./db').init_db;

_ref = require('./auth'), init_auth = _ref.init_auth, is_logged_in = _ref.is_logged_in;

get_config = require('./config').get_config;

_ref1 = require('./handlers/event'), create_event_post = _ref1.create_event_post, create_event_get = _ref1.create_event_get, edit_event_get = _ref1.edit_event_get, edit_event_post = _ref1.edit_event_post, delete_event = _ref1.delete_event, event_view_get = _ref1.event_view_get;

welcome_page_get = require('./handlers/welcome_page').welcome_page_get;

my_events_get = require('./handlers/events_list').my_events_get;

UserEvent = require('./models/userEvent');

config = get_config();

app = express();

app.set('views', __dirname);

app.set('view engine', 'ejs');

app.use(express["static"](path.resolve(__dirname, '../../public')));

app.use(express["static"](path.resolve(__dirname, '../../image')));

app.use(cookieParser());

app.use(bodyParser.json());

app.use(bodyParser.urlencoded());

app.use(expressValidator());

app.use(session({
  secret: "redis_session_secret",
  store: new RedisStore({
    host: config.redis_host,
    port: config.redis_port,
    pass: config.redis_pass,
    db: config.redis_db
  })
}));

app.use(passport.initialize());

app.use(passport.session());

init_db(config.db_path);

init_auth();

app.get('/', welcome_page_get);

app.get('/event/:eventId', event_view_get);

app.get('/create_event', is_logged_in, create_event_get);

app.post('/create_event', is_logged_in, create_event_post);

app.get('/edit_event/:eventId', is_logged_in, edit_event_get);

app.post('/edit_event/:eventId', is_logged_in, edit_event_post);

app.post('/delete_event/:eventId', is_logged_in, delete_event);

app.get('/my_events', is_logged_in, my_events_get);

app.get('/auth/google', function(req, res, next) {
  req.session.redirect = req.query.r;
  return next();
}, passport.authenticate('google'));

app.get('/auth/google/return', passport.authenticate('google'), function(req, res) {
  res.redirect(req.session.redirect || "back");
  return delete req.session.redirect;
});

server = app.listen(config.port, function() {
  return console.log("Listening port " + config.port);
});
