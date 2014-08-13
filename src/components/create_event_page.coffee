React = require 'react'
{div, h1, a} = React.DOM

CreateEventPage = React.createClass
    displayName: "CreateEventPage"

    propTypes:
        user: React.PropTypes.object

    render: ->
        div {},
            h1 {}, "Create your event event!!!"


module.exports = CreateEventPage