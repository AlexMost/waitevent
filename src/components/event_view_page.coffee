React = require 'react'
{div, h1, p, ul, li, span, a, button, img, small} = React.DOM
PageBase = require './portlets/base'
CountDown = require './portlets/countdown'
FlipClock = require './portlets/flipclock'
Popover = require './portlets/popover'
{AuthPopup} = require './portlets/auth_popup'
{TwitterButton, FacebookButton, GoogleButton} = require './portlets/social'


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
        currentUrl: ""

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
            else
                button
                    className: "h-ml-5 btn btn-success btn-xs"
                    onClick: @props.onAuth
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
        div {},
            PageBase {user: @props.user},

                h1
                    className: "text-center event-page-header"
                    style:
                        "font-size": "45px"
                        "font-weight": "bold"
                        "margin-top": "10%"
                    @props.event.title

                div
                    className: "text-center event-deadline-header"
                    style:
                        "margin-bottom": "5%"
                    "(#{(new Date @props.event.deadLine).toLocaleString()})"


                div {className: "row"},
                    div {className: "col-md-12 text-right h-pr-0"},
                        EventJoinButton
                            participants: @props.participants
                            user: @props.user
                            onJoin: @props.onJoinEvent
                            onUnjoin: @props.onUnjoinEvent
                            onAuth: => @refs.auth.show()

                div
                    className: "well row text-center"
                    style: {"margin-bottom": "10%"}

                    div {className: "col-md-2"}
                    div {className: "col-md-8"},
                        FlipClock
                            target_date: @props.event.deadLine
                    div {className: "col-md-2"}
                
                if @props.event.description
                    div {className: "text-center event-description"},
                        p {}, @props.event.description

                if @props.event.links?.length
                    div {className: "text-center event-links"},
                        (for l, i in @props.event.links
                            do (l, i) ->
                                p {key: i},
                                    span {}, l.text
                                    span {}, " - "
                                    a {href: l.url}, l.url
                        )
                AuthPopup
                    ref: "auth"
                    callbackUrl: @props.currentUrl

            div {style: {"margin-bottom": "40px"}}

            if (@props.event.shareTwitter or
                    @props.event.shareFacebook or
                    @props.event.shareGoogle)

                div {className: "text-center social-panel box-shadow"},
                    div {style: {width: "100%", height: "5px"}}, ""
                    if @props.event.shareTwitter
                        TwitterButton()
                    if @props.event.shareFacebook
                        FacebookButton()
                    if @props.event.shareGoogle
                        GoogleButton()


module.exports = EventViewPage