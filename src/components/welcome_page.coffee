React = require 'react'
{div, h1, a} = React.DOM

WelcomePage = React.createClass
    displayName: "WelcomePage"

    render: ->
        div {},
            h1 {}, "Wait event"
            div {},
                a
                    href: "#"
                    onClick: (ev) ->
                        console.log "clicked ..."
                        ev.preventDefault()
                    "Authorize"
            div {},
                a
                    href: "#"
                    onClick: (ev) ->
                        console.log "clicked 2 ..."
                        ev.preventDefault()
                    "CreateEvent"


module.exports = WelcomePage