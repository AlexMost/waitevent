React = require 'react'
{div, script, label, span} = React.DOM
SetIntervalMixin = require '../mixins/interval'


CountDown = React.createClass
    displayName: "EventViewPage"

    mixins: [SetIntervalMixin]

    componentDidMount: ->
        @setInterval @tick, 1000

    tick: ->
        console.log "tick"

    getDefaultProps: ->
        dateNow: new Date().getTime()

    render: ->
        div {}, @props.dateNow


module.exports = CountDown