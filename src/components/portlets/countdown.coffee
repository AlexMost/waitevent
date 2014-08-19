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
        span {},
            span {}, "("
            span {}, @state.days
            span {className: "countdown-word"},
                "days"

            span {}, @state.hours
            span {className: "countdown-word"},
                "hours"

            span {}, @state.minutes
            span {className: "countdown-word"},
                "minutes"

            span {}, @state.seconds
            span {className: "countdown-word"},
                "seconds"
            span {}, ")"


module.exports = CountDown