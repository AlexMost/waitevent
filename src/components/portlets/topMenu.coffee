React = require 'react'
{div, a, ul, li} = React.DOM


TopMenu = React.createClass
    displayName: "TopMenu"

    propTypes:
        user: React.PropTypes.object

    renderAuth: ->
        (div {className: "text-right"},
            (ul {className:"list-inline"},
                ((li null, (a {href: "/"}, "Home")))
                (li null, (a {href: "/my_events"}, "My events"))
                (li null, (a {href: "/watch_events"}, "Watching"))
            )
            (a {href: "/create_event"}, "Create new event")
        )

    renderUnAuth: ->
        (div {className: "text-right"},
            (a {href: "/create_event"}, "Create new event"))

    render: ->
        if @props.user
            @renderAuth()
        else
            @renderUnAuth()


module.exports = TopMenu