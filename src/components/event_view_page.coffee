React = require 'react'
{div, h1, p, ul, li, span, a, button, img} = React.DOM
PageBase = require './portlets/base'
CountDown = require './portlets/countdown'
FlipClock = require './portlets/flipclock'
Popover = require './portlets/popover'

Participants = React.createClass
    displayName: "Participants"
    render: ->
        div {className: "participants-container"},
            @props.participants.map (p) ->
                div {className: "participant-item", key: p.id},
                    a {
                        className: "participant-link"
                        href: p.link
                        target: "_blank"},
                        span {className: "participant-name"}, p.name
                        img {src: "#{p.picture50}"}
            div {className: "clear"}


EventJoinButton = React.createClass
    displayName: "EventJoinButton"


    propTypes:
        participants: React.PropTypes.array
        user: React.PropTypes.object

    getDefaultProps: ->
        participants: []

    render: ->
        partIds = @props.participants.map (p) -> p.id
        div {className: "join-container"},
            span {className: "h-ml-5 participants-number"},
                @props.participants.length

            span
                ref: "participants"
                className: "h-ml-5 participants-text"
                onClick: => @refs.part_popup.toggle()
                "participants"

            Popover(
                width: 200
                title: "Event participants"
                ref: "part_popup"
                source: => @refs.participants
                Participants
                    participants: @props.participants
            )

            if @props.user
                if @props.user._id.toString() in partIds
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
        participants: React.PropTypes.array
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
                        participants: @props.participants
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
                p {dangerouslySetInnerHTML: {
                    __html: @props.event.description}}


module.exports = EventViewPage