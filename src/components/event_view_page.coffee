React = require 'react'
{div, h1, p} = React.DOM
PageBase = require './portlets/base'
CountDown = require './portlets/countdown'


EventViewPage = React.createClass
    displayName: "EventViewPage"

    propTypes:
        event: React.PropTypes.object

    render: ->
        PageBase {user: @props.user},
            h1 {className: "text-center"},
                @props.event.title
            new CountDown
                target_date: new Date(@props.event.deadLine).getTime()
            div {className: "text-center"},
                p {}, @props.event.description



module.exports = EventViewPage