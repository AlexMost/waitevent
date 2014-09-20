React = require 'react'
{div, h1, a, button} = React.DOM
PageBase = require './portlets/base'
{AuthPopup} = require './portlets/auth_popup'


WelcomePage = React.createClass
    displayName: "WelcomePage"

    propTypes:
        user: React.PropTypes.object

    render: ->
        create_link_url = if @props.user
            "/create_event"
        else
            "/auth/google?r=/create_event"

        PageBase({user: @props.user},
            (div {className: "row"},
                (div {className: "col-md-12"},
                    (h1
                        className: "text-center"
                        style: {"margin-top": "20%"}
                        "Create countdown for some event:"
                    )
                )
            )
            if @props.user
                (div {className: "row"},
                    (div {className: "col-md-12 text-center"},
                        (a
                            href: "/create_event"
                            className: "btn btn-success btn-lg"
                            style: {"margin-top": "5%"}
                            "Create"
                        )
                    )
                )
            else
                (div {className: "row"},
                    (div {className: "col-md-12 text-center"},
                        (button
                            onClick: => @refs.auth.show()
                            className: "btn btn-success btn-lg"
                            style: {"margin-top": "5%"}
                            "Create"
                        )
                    )
                )
            AuthPopup
                ref: "auth"
                callbackUrl: "/create_event"
        )


module.exports = WelcomePage