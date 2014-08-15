React = require 'react'
{div, h1, a} = React.DOM
PageBase = require './portlets/base'

CreateEventPage = React.createClass
    displayName: "CreateEventPage"

    propTypes:
        user: React.PropTypes.object

    render: ->
        PageBase({user: @props.user},
            h1 {}, "Create your event event!!!"
        )


module.exports = CreateEventPage