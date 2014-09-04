passport = require 'passport'
GoogleStrategy = require('passport-google-oauth').OAuth2Strategy
User = require './models/user'
{get_config} = require './config'


init_auth = ->
    config = get_config()
    
    callbackURL = if config.local
        "#{config.hostname}:#{config.port}/auth/google/return"
    else
        config.hostname
    
    passport.use(
        (new GoogleStrategy
            clientID: config.googleClientId
            clientSecret: config.googleClientSecret
            callbackURL: callbackURL
            (token, refreshTocken, profile, done) ->
                User.findOne {googleid: profile.id}, (err, user) ->
                    return done err if err
                    if user
                        done null, user
                    else
                        newUser = new User {
                            googleid: profile.id
                            googleProfile: profile
                        }
                        newUser.save (err, user) ->
                            done err, user
        )
    )


    passport.serializeUser (user, done) ->
        done(null, user._id)


    passport.deserializeUser (id, done) ->
        User.findOne {_id: id}, done


is_logged_in = (req, res, next) ->
    if req.isAuthenticated()
        next()
    else
        res.redirect '/'


module.exports = {init_auth, is_logged_in}