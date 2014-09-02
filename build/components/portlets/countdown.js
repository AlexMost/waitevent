var CountDown, React, SetIntervalMixin, div, label, script, span, _ref;

React = require('react');

_ref = React.DOM, div = _ref.div, script = _ref.script, label = _ref.label, span = _ref.span;

SetIntervalMixin = require('../mixins/interval');

CountDown = React.createClass({
  displayName: "EventViewPage",
  mixins: [SetIntervalMixin],
  getInitialState: function() {
    return {
      has_appeared: false,
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0
    };
  },
  componentDidMount: function() {
    return this.setInterval(this.tick, 1000);
  },
  tick: function() {
    var current_date, days, hours, minutes, seconds, seconds_left;
    current_date = new Date().getTime();
    seconds_left = (this.props.target_date - current_date) / 1000;
    days = parseInt(seconds_left / 86400);
    seconds_left = seconds_left % 86400;
    hours = parseInt(seconds_left / 3600);
    seconds_left = seconds_left % 3600;
    minutes = parseInt(seconds_left / 60);
    seconds = parseInt(seconds_left % 60);
    if ((days + hours + minutes + seconds) > 0) {
      return this.setState({
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds
      });
    } else {
      return this.setState({
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0
      });
    }
  },
  render: function() {
    return span({}, span({}, "("), span({}, this.state.days), span({
      className: "countdown-word"
    }, "days"), span({}, this.state.hours), span({
      className: "countdown-word"
    }, "hours"), span({}, this.state.minutes), span({
      className: "countdown-word"
    }, "minutes"), span({}, this.state.seconds), span({
      className: "countdown-word"
    }, "seconds"), span({}, ")"));
  }
});

module.exports = CountDown;
