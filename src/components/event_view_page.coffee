React = require 'react'
{div, h1, a, form, script} = React.DOM
PageBase = require './portlets/base'


EventViewPage = React.createClass
    displayName: "EventViewPage"

    propTypes:
        event: React.PropTypes.object

    render: ->
        PageBase {user: @props.user},
            h1 {className: "text-center"},
                @props.event.title
            div {}, "created #{@props.event.createdAt}"
            div {}, @props.event.description
            div {}, @props.event.deadLine


module.exports = EventViewPage