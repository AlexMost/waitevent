React = require 'react'
{div, h1} = React.DOM

WelcomePage = React.createClass
    displayName: "WelcomePage"
    render: ->
        div {},
            h1 {}, "Hello from rendered component"
            div {}, "Weeeeeee"

module.exports = WelcomePage