passport = require 'passport'
GoogleStrategy = require('passport-google').Strategy


init_auth = ->
    passport.use(
        (new GoogleStrategy
            returnURL: 'http://localhost:3000/auth/google/return',
            realm: 'http://localhost:3000'
            (id, profile, done) ->
                # TODO: create or get user
                done null, profile
        )
    )

    passport.serializeUser (user, done) ->
        done(null, user)

    passport.deserializeUser (user, done) ->
        done(null, user)


module.exports = {init_auth}