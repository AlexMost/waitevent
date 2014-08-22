React = require 'react'
{div, h1, p, ul, li, span, a, b, small} = React.DOM
PageBase = require './portlets/base'
CountDown = require './portlets/countdown'
Modal = require './portlets/modal'


getEventsGroups = (events) ->

    to_groups = (res, ev) ->
        date = (new Date ev.createdAt).toLocaleDateString()
        unless date of res
            res[date] = {date, events: [ev]}
        else
            res[date].events.push ev
        res

    groups = events.reduce to_groups, {}

    sort_events = (ev1, ev2) -> (new Date ev2) - (new Date ev1)
    sorted_events = ([d, e.events.sort(sort_events)] for d, e of groups)
    sorted_events.sort ([d1], [d2]) -> d1 - d2


EventsItemToolbar = React.createClass
    displayName: "EventsItemToolbar"

    getDefaultProps: ->
        onDelete: ->

    render: ->
        div {},
            a
                ref: 'watch_btn'
                href: "#"
                onClick: (ev) -> ev.preventDefault()
                title: "Add this event to watch list"
                onMouseEnter: => $(@refs.watch_btn.getDOMNode()).tooltip()
                span
                    className: "glyphicon glyphicon-eye-open toolbar-icon"
            a
                ref: 'edit_btn'
                href: "/edit_event/#{@props.event._id}"
                title: "Edit event"
                onMouseEnter: => $(@refs.edit_btn.getDOMNode()).tooltip()
                span
                    className: "glyphicon glyphicon-pencil toolbar-icon"
            a
                href: "#"
                ref: "del_btn"
                onClick: (ev) => 
                    ev.preventDefault()
                    @props.onDelete @props.event
                title: "Remove this event"
                onMouseEnter: => $(@refs.del_btn.getDOMNode()).tooltip()
                span
                    className: "glyphicon glyphicon-remove toolbar-icon"


EventListItem = React.createClass
    displayName: "EventListItem"

    getDefaultProps: ->
        onDelete: ->

    render: ->
        date = new Date @props.event.createdAt
        target_date = new Date @props.event.deadLine

        div {className: "panel panel-default"},
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

            div {className: "panel-body"},
                p {}, @props.event.description


EventsGroup = React.createClass
    displayName: "EventsGroup"

    getDefaultProps: ->
        onDelte: ->

    propTypes:
        events: React.PropTypes.array
        date: React.PropTypes.string

    render: ->
        ul {className: "list-unstyled"},
            @props.events.map (event) =>
                li {key: event._id}, new EventListItem(
                    {
                        event
                        onDelete: @props.onDelete
                    })


MyEventsEventsListPage = React.createClass
    displayName: "MyEventsEventsListPage"

    propTypes:
        events: React.PropTypes.array
        user: React.PropTypes.object

    getInitialState: ->
        groups: []

    componentWillMount: ->
        groups = getEventsGroups @props.events
        @setState {groups}

    render: ->
        PageBase {user: @props.user},
            h1
                style:
                    "margin-bottom": "5%"
                "My events"

            @state.groups.map ([date, events]) ->
                [
                    p {className: "event-group text-center"},
                        new Date(date).toDateString()
                    new EventsGroup
                        key: "key_e_g#{date}"
                        date: date
                        events: events
                        onDelete: (event) -> $("#myModal").modal()
                ]
            Modal()


            

module.exports = MyEventsEventsListPage
