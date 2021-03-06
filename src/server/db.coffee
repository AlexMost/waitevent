mongoose = require 'mongoose'

init_db = (connection_string) ->
    mongoose.connect connection_string
    db = mongoose.connection
    db.on 'error', console.error.bind console, 'connection error:'
    db.on 'open', -> console.log 'db connected successfully'

    # registering models
    require './models/user'
    require './models/userEvent'


module.exports = {init_db}