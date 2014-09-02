passport = require 'passport'
GoogleStrategy = require('passport-google').Strategy
User = require './models/user'
{get_config} = require './config'


init_auth = ->
    config = get_config()
    
    passport.use(
        (new GoogleStrategy
            returnURL: "#{config.hostname}:#{config.port}/auth/google/return",
            realm: "#{config.hostname}:#{config.port}"
            (googleid, googleProfile, done) ->
                User.findOne {googleid}, (err, user) ->
                    return done err if err
                    if user
                        done null, user
                    else
                        newUser = new User {googleid, googleProfile}
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