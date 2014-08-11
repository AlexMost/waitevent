express = require 'express'
mongoose = require 'mongoose'
mongoose.connect('mongodb://33.33.33.10/waitevent')
db = mongoose.connection

db.on 'error', console.error.bind console, 'connection error:'
db.on 'open', -> console.log 'db connected successfully'

app = express()

app.get '/', (req, res) ->
    res.send('It works')

server = app.listen(3000, -> console.log 'Listening port 3000')