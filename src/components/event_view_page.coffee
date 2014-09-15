React = require 'react'
{div, h1, p, ul, li, span, a, button, img} = React.DOM
PageBase = require './portlets/base'
CountDown = require './portlets/countdown'
FlipClock = require './portlets/flipclock'
Popover = require './portlets/popover'

Participants = React.createClass
    displayName: "Participants"
    render: ->
        div {},
            @props.participants.map (p) ->
                div {},
                    img {src: "#{p.googleProfile._json.picture}?sz=50"}



EventJoinButton = React.createClass
    displayName: "EventJoinButton"


    propTypes:
        event: React.PropTypes.object
        user: React.PropTypes.object


    getInitialState: ->
        showPopup: false


    render: ->
        eventIds = @props.event.participants.map (p) ->
            p._id.toString()

        div {className: "join-container"},
            span {className: "h-ml-5 participants-number"},
                @props.event.participants.length

            span
                ref: "participants"
                className: "h-ml-5 participants-text"
                onClick: => @setState {showPopup: !@state.showPopup}
                "participants"

            if @state.showPopup
                Popover(
                    title: "Event participants"
                    ref: "part_popup"
                    source: @refs.participants
                    Participants
                        participants: @props.event.participants
                )

            if @props.user
                if @props.user._id.toString() in eventIds
                    button
                        className: "h-ml-5 btn btn-default btn-xs"
                        onClick: @props.onUnjoin
                        span {className: "glyphicon glyphicon-minus"}
                else
                    button
                        className: "h-ml-5 btn btn-success btn-xs"
                        onClick: @props.onJoin
                        span {className: "glyphicon glyphicon-plus"}
                        span {className: "join-text"}, "join"


EventViewPage = React.createClass
    displayName: "EventViewPage"

    propTypes:
        event: React.PropTypes.object
        onJoinEvent: React.PropTypes.func
        onUnjoinEvent: React.PropTypes.func

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

            div {className: "row"},
                div {className: "col-md-12 text-right h-pr-0"},
                    EventJoinButton
                        event: @props.event
                        user: @props.user
                        onJoin: @props.onJoinEvent
                        onUnjoin: @props.onUnjoinEvent

            div
                className: "well row text-center"
                style: {"margin-bottom": "10%"}

                div {className: "col-md-2"}
                div {className: "col-md-8"},
                    FlipClock
                        target_date: @props.event.deadLine
                div {className: "col-md-2"}
                
            div {className: "text-center event-description"},
                p {}, @props.event.description


module.exports = EventViewPage