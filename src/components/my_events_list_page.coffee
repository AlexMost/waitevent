React = require 'react'
{div, h1, p, ul, li, span, a, b, small} = React.DOM
PageBase = require './portlets/base'


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


EventListItem = React.createClass
    displayName: "EventListItem"

    render: ->
        date = new Date @props.event.createdAt

        div {className: "panel panel-default"},
            div {className: "panel-heading"},
                b {},
                    a {href: "/event/#{@props.event._id}"},
                        span {}, @props.event.title

                    small {style: {"margin-left": "20px"}},
                        "(#{date.toLocaleTimeString()})"

            div {className: "panel-body"},
                @props.event.description


EventsGroup = React.createClass
    displayName: "EventsGroup"

    propTypes:
        events: React.PropTypes.array
        date: React.PropTypes.string

    render: ->
        ul {className: "list-unstyled"},
            @props.events.map (event) ->
                li {key: event._id}, new EventListItem {event}



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
                className: "text-center"
                style:
                    "margin-bottom": "5%"
                    "margin-top": "5%"
                "My events"

            @state.groups.map ([date, events]) ->
                [
                    p {}, new Date(date).toDateString()
                    new EventsGroup
                        key: "key_e_g#{date}"
                        date: date
                        events: events
                ]
            

module.exports = MyEventsEventsListPage
