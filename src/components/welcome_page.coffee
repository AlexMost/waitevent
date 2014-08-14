React = require 'react'
{div, h1, a, button} = React.DOM
PageBase = require './portlets/base'


WelcomePage = React.createClass
    displayName: "WelcomePage"

    propTypes:
        user: React.PropTypes.object

    render: ->
        PageBase({user: @props.user},
            (div {className: "row"},
                (div {className: "col-md-12"},
                    (h1
                        className: "text-center"
                        style: {"margin-top": "20%"}
                        "Create timer for some event:"
                    )
                )
            )
            (div {className: "row"},
                (div {className: "col-md-12 text-center"},
                    (a
                        href: if @props.user
                                "/create_event"
                            else
                                "/auth/google?r=/create_event"
                        className: "btn btn-success btn-lg"
                        style: {"margin-top": "5%"}
                        "Create"
                    )
                )
            )
        )


module.exports = WelcomePage