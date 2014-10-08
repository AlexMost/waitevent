React = require 'react'
{div, a, ul, li, span, button} = React.DOM
{AuthPopup} = require './auth_popup'


TopMenu = React.createClass
    displayName: "TopMenu"

    propTypes:
        user: React.PropTypes.object

    renderAuth: ->
        (div {className: "text-right"},
            (ul {className:"list-inline top-menu"},
                (li {className: "top-menu-item"},
                    (span {
                        className: "glyphicon glyphicon-home"
                        style: "margin-right": "5px"})
                    (a {
                        href: "/"
                        className: "color-default"},
                        "Home"))

                if @props.user.joinedEvents.length
                    (li {className: "top-menu-item"},
                        (span {
                            className: "glyphicon glyphicon-star"
                            style: "margin-right": "5px"})
                        (a {
                            href: "/joined_events"
                            className: "color-default"},
                            "Joined events"
                            (span
                                className:"badge h-ml-5"
                                @props.user.joinedEvents.length)
                            ))

                (li {className: "top-menu-item"},
                    (a {
                        href: "/my_events"
                        className: "color-default"},
                        "My events"))

                (li {className: "top-menu-item"},
                    (a {
                        className: "btn btn-success btn-xs"
                        href: "/create_event"}, "Create new event"))
            )
        )

    renderUnAuth: ->
        div {className: "text-right"},
            ul {className: "list-inline top-menu"},
                li {className: "top-menu-item"},
                    button
                        className: "btn btn-success btn-xs"
                        onClick: => @refs.auth.show()
                        "Sign in"

            AuthPopup
                ref: "auth"
                callbackUrl: "/create_event"


    render: ->
        if @props.user
            @renderAuth()
        else
            @renderUnAuth()


module.exports = TopMenu