var CountDown, EventViewPage, FlipClock, PageBase, React, a, div, h1, li, p, span, ul, _ref;

React = require('react');

_ref = React.DOM, div = _ref.div, h1 = _ref.h1, p = _ref.p, ul = _ref.ul, li = _ref.li, span = _ref.span, a = _ref.a;

PageBase = require('./portlets/base');

CountDown = require('./portlets/countdown');

FlipClock = require('./portlets/flipclock');

EventViewPage = React.createClass({
  displayName: "EventViewPage",
  propTypes: {
    event: React.PropTypes.object
  },
  render: function() {
    return PageBase({
      user: this.props.user
    }, h1({
      className: "text-center event-page-header",
      style: {
        "font-size": "45px",
        "font-weight": "bold",
        "margin-bottom": "10%",
        "margin-top": "10%"
      }
    }, this.props.event.title), div({
      className: "well row text-center",
      style: {
        "margin-bottom": "10%"
      }
    }, div({
      className: "col-md-2"
    }), div({
      className: "col-md-8"
    }, FlipClock({
      target_date: this.props.event.deadLine
    })), div({
      className: "col-md-2"
    })), div({
      className: "text-center event-description"
    }, p({}, this.props.event.description)));
  }
});

module.exports = EventViewPage;
