var GoogleStrategy, User, get_config, init_auth, is_logged_in, passport;

passport = require('passport');

GoogleStrategy = require('passport-google').Strategy;

User = require('./models/user');

get_config = require('./config').get_config;

init_auth = function() {
  var config;
  config = get_config();
  passport.use(new GoogleStrategy({
    returnURL: "" + config.hostname + ":" + config.port + "/auth/google/return",
    realm: "" + config.hostname + ":" + config.port
  }, function(googleid, googleProfile, done) {
    return User.findOne({
      googleid: googleid
    }, function(err, user) {
      var newUser;
      if (err) {
        return done(err);
      }
      if (user) {
        return done(null, user);
      } else {
        newUser = new User({
          googleid: googleid,
          googleProfile: googleProfile
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
