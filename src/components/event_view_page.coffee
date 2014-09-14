React = require 'react'
{div, h1, p, ul, li, span, a, button} = React.DOM
PageBase = require './portlets/base'
CountDown = require './portlets/countdown'
FlipClock = require './portlets/flipclock'


EventViewPage = React.createClass
    displayName: "EventViewPage"

    propTypes:
        event: React.PropTypes.object
        onJoinEvent: React.PropTypes.func

    render: ->
        PageBase {user: @props.user},

            h1
                className: "text-center event-page-header"
                style:
                    "font-size": "45px"
                    "font-weight": "bold"
                    "margin-bottom": "10%"
                    "margin-top": "10%"
                @props.event.title

            div
                className: "well row text-center"
                style: {"margin-bottom": "10%"}

                div {className: "col-md-2"}
                div {className: "col-md-8"},
                    FlipClock
                        target_date: @props.event.deadLine
                div {className: "col-md-2"}

            div {},
                button
                    className: "btn btn-success"
                    onClick: @props.onJoinEvent
                    "join"
                span {style: {"margin-right": "5px"}},
                    "participants"
                span {}, @props.event.participants.length

            div {className: "text-center event-description"},
                p {}, @props.event.description




module.exports = EventViewPage