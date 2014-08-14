React = require 'react'
{div, a, ul, li} = React.DOM


TopMenu = React.createClass
    displayName: "TopMenu"

    propTypes:
        user: React.PropTypes.object

    renderAuth: ->
        (ul {className:"list-inline"},
            (li null, (a {href: "/my-events"}, "My events"))
            (li null, (a {href: "/watch-events"}, "Watching"))
        )

    renderUnAuth: ->
        (ul {className:"list-inline"},
            (li null, (a {href: "/auth/google"}, "Authorize"))
        )

    render: ->
        if @props.user
            @renderAuth()
        else
            @renderUnAuth()


module.exports = TopMenu