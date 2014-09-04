var GoogleStrategy, User, get_config, init_auth, is_logged_in, passport;

passport = require('passport');

GoogleStrategy = require('passport-google-oauth').OAuth2Strategy;

User = require('./models/user');

get_config = require('./config').get_config;

init_auth = function() {
  var callbackURL, config;
  config = get_config();
  callbackURL = config.local ? "" + config.hostname + ":" + config.port + "/auth/google/return" : "" + config.hostname + "/auth/google/return";
  console.log(callbackURL);
  passport.use(new GoogleStrategy({
    clientID: config.googleClientId,
    clientSecret: config.googleClientSecret,
    callbackURL: callbackURL
  }, function(token, refreshTocken, profile, done) {
    return User.findOne({
      googleid: profile.id
    }, function(err, user) {
      var newUser;
      if (err) {
        return done(err);
      }
      if (user) {
        return done(null, user);
      } else {
        newUser = new User({
          googleid: profile.id,
          googleProfile: profile
        });
        return newUser.save(function(err, user) {
          return done(err, user);
        });
      }
    });
  }));
  passport.serializeUser(function(user, done) {
    return done(null, user._id);
  });
  return passport.deserializeUser(function(id, done) {
    return User.findOne({
      _id: id
    }, done);
  });
};

is_logged_in = function(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  } else {
    return res.redirect('/');
  }
};

module.exports = {
  init_auth: init_auth,
  is_logged_in: is_logged_in
};
