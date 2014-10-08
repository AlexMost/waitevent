React = require 'react'
{div, h1, p, ul, li, span, a, b, small, button} = React.DOM
PageBase = require './portlets/base'
CountDown = require './portlets/countdown'


EventsItemToolbar = React.createClass
    displayName: "EventsItemToolbar"

    getDefaultProps: ->
        onDelete: ->

    render: ->
        div {},
            button
                ref: "unjoin_btn"
                className: "h-ml-5 btn btn-default btn-xs"
                onClick: => @props.onUnjoin @props.event
                title: "unjoin event"
                onMouseEnter: => $(@refs.unjoin_btn.getDOMNode()).tooltip()
                span {className: "glyphicon glyphicon-minus"}


EventListItem = React.createClass
    displayName: "EventListItem"

    getDefaultProps: ->
        onDelete: ->

    render: ->
        date = new Date @props.event.createdAt
        target_date = new Date @props.event.deadLine

        div {className: "panel panel-default box-shadow"},
            div {className: "panel-heading"},
                div {className: "row"},
                    div {className: "col-md-11"},
                        b {},
                            a {href: "/event/#{@props.event._id}"},
                                span
                                    className: "event-title"
                                    @props.event.title
                            span {className: "countdown"},
                                new CountDown {target_date}
                    div {className: "col-md-1 text-center"},
                        new EventsItemToolbar
                            event: @props.event
                            onDelete: @props.onDelete
                            onUnjoin: @props.onUnjoin

            div {className: "panel-body"},
                p {}, @props.event.description


EventsGroup = React.createClass
    displayName: "EventsGroup"

    getDefaultProps: ->
        onDelte: ->

    propTypes:
        events: React.PropTypes.array

    render: ->
        ul {className: "list-unstyled"},
            @props.events.map (event) =>
                li {key: event._id}, new EventListItem(
                    {
                        event
                        onDelete: @props.onDelete
                        onUnjoin: @props.onUnjoin
                    })


JoinedEventsEventsListPage = React.createClass
    displayName: "JoinedEventsEventsListPage"

    propTypes:
        events: React.PropTypes.array
        user: React.PropTypes.object

    getInitialState: ->
        groups: []
        delItem: {}

    render: ->
        PageBase {user: @props.user},
            h1
                style:
                    "margin-bottom": "5%"
                "Joined events (#{@props.events.length})"

            div {},
                new EventsGroup
                    events: @props.events
                    onUnjoin: @props.onUnjoinEvent
            

module.exports = JoinedEventsEventsListPage
