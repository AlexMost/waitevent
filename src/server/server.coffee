path = require 'path'
express = require 'express'
React = require 'react'
{init_db} = require './db'
WelcomePage = require '../components/welcome_page'


reactRender = (res, componentClass, props) ->
    component = new componentClass props
    str = React.renderComponentToString component
    res.render('layout', {reactOutput: str})


init_db 'mongodb://33.33.33.10/waitevent'
app = express()
app.set 'views', __dirname
app.set 'view engine', 'ejs'
app.use express.static(path.join(__dirname, 'public'))



app.get '/', (req, res) ->
    reactRender res, WelcomePage, {}


server = app.listen(3000, -> console.log 'Listening port 3001')
