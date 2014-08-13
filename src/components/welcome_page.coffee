React = require 'react'
{div, h1, a} = React.DOM


WelcomePage = React.createClass
    displayName: "WelcomePage"


    propTypes:
        user: React.PropTypes.object


    render: ->
        div {},
            h1 {}, "Wait event!!!"
            div {},
                unless @props.user
                    a
                        href: "#"
                        onClick: (ev) ->
                            console.log "clicked ..."
                            ev.preventDefault()
                        "Authorize"
            div {},
                a
                    href: "/create_event"
                    "CreateEvent"


module.exports = WelcomePage