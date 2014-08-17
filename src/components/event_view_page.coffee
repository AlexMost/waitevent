React = require 'react'
{div, h1, p, ul, li, span, a} = React.DOM
PageBase = require './portlets/base'
CountDown = require './portlets/countdown'
FlipClock = require './portlets/flipclock'


EventViewPage = React.createClass
    displayName: "EventViewPage"

    propTypes:
        event: React.PropTypes.object

    render: ->
        PageBase {user: @props.user},
            h1
                className: "text-center"
                style:
                    "margin-bottom": "5%"
                    "margin-top": "5%"
                @props.event.title
            div
                className: "well row text-center"
                style: {"margin-bottom": "5%"}

                div {className: "col-md-2"}
                div {className: "col-md-8"},
                    FlipClock
                        target_date: @props.event.deadLine
                div {className: "col-md-2"}
            div {className: "text-center"},
                p {}, @props.event.description




module.exports = EventViewPage