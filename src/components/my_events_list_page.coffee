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
                ref: 'edit_btn'
                href: "/edit_event/#{@props.event._id}"
                title: "Edit event"
                className: "color-default"
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
                className: "color-default"
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
                    })


MyEventsEventsListPage = React.createClass
    displayName: "MyEventsEventsListPage"

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
                "My events"

            if @props.events.length > 0
                div {},
                    new EventsGroup
                        events: @props.events
                        onDelete: (event) =>
                            @setState {delItem: event}, -> $("#myModal").modal()

                    Modal(
                        title: "Confirm delete"
                        onConfirm: =>
                            $.ajax(
                                type: "POST"
                                url: "/delete_event/#{@state.delItem._id}"
                                data: {}
                                success: =>
                                    newEvents = @props.events.filter (ev) =>
                                        ev._id != @state.delItem._id
                                    @setProps {events: newEvents}
                            )
                            $("#myModal").modal('hide')

                        div {},
                            "Delete item #{@state.delItem.title}?"
                    )
            else
                div {},
                    div {}, "You have no events yet"
                    div {},
                        (a
                            href: "/create_event"
                            className: "btn btn-success btn-lg"
                            style: {"margin-top": "5%"}
                            "Create first event"
                        )

            

module.exports = MyEventsEventsListPage
