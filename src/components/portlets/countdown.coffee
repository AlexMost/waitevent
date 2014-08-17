React = require 'react'
{div, script, label, span} = React.DOM
SetIntervalMixin = require '../mixins/interval'


CountDown = React.createClass
    displayName: "EventViewPage"

    mixins: [SetIntervalMixin]

    getInitialState: ->
        has_appeared: false
        days: 0
        hours: 0
        minutes: 0
        seconds: 0

    componentDidMount: ->
        @setInterval @tick, 1000

    tick: ->
        # find the amount of "seconds" between now and target
        current_date = new Date().getTime()
        seconds_left = (@props.target_date - current_date) / 1000

        days = parseInt(seconds_left / 86400)
        seconds_left = seconds_left % 86400

        hours = parseInt(seconds_left / 3600)
        seconds_left = seconds_left % 3600

        minutes = parseInt(seconds_left / 60)
        seconds = parseInt(seconds_left % 60)

        if (days + hours + minutes + seconds) > 0
            @setState {days, hours, minutes, seconds}
        else
            @setState {days: 0, hours: 0, minutes: 0, seconds: 0}

    render: ->
        div {className: "row text-center"},
            div {className: "col-md-2"}
            div {className: "col-md-2"},
                span {}, @state.days
                span {}, "Days"
            div {className: "col-md-2"},
                span {}, @state.hours
                span {}, "Hours"
            div {className: "col-md-2"},
                span {}, @state.minutes
                span {}, "Minutes"
            div {className: "col-md-2"},
                span {}, @state.seconds
                span {}, "Seconds"
            div {className: "col-md-2"}

module.exports = CountDown