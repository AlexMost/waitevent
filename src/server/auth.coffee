passport = require 'passport'
GoogleStrategy = require('passport-google').Strategy
User = require './models/user'


init_auth = ->
    passport.use(
        (new GoogleStrategy
            returnURL: 'http://localhost:3000/auth/google/return',
            realm: 'http://localhost:3000'
            (googleid, googleProfile, done) ->
                User.find {googleid}, (err, users) ->
                    return done err if err
                    if users.length
                        done null, users[0]
                    else
                        newUser = new User {googleid, googleProfile}
                        newUser.save (err, user) ->
                            done err, user
        )
    )

    passport.serializeUser (user, done) ->
        done(null, user)

    passport.deserializeUser (user, done) ->
        done(null, user)


is_logged_in = (req, res, next) ->
    if req.user
        next()
    else
        res.redirect '/'

module.exports = {init_auth, is_logged_in}