(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var EventViewPage, React, componentData, mountNode;

React = window.React;

EventViewPage = require('../components/event_view_page');

mountNode = document.getElementById("react-main-mount");

componentData = JSON.parse((document.getElementById("componentData")).innerHTML);

React.renderComponent(new EventViewPage(componentData), mountNode);

},{"../components/event_view_page":2}],2:[function(require,module,exports){
var CountDown, EventViewPage, FlipClock, PageBase, React, a, div, h1, li, p, span, ul, _ref;

React = window.React;

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

},{"./portlets/base":4,"./portlets/countdown":5,"./portlets/flipclock":6}],3:[function(require,module,exports){
var SetIntervalMixin;

SetIntervalMixin = {
  componentWillMount: function() {
    return this.intervals = [];
  },
  setInterval: function() {
    return this.intervals.push(setInterval.apply(null, arguments));
  },
  componentWillUnmount: function() {
    return this.intervals.map(clearInterval);
  }
};

module.exports = SetIntervalMixin;

},{}],4:[function(require,module,exports){
var PageBase, React, TopMenu, div;

React = window.React;

div = React.DOM.div;

TopMenu = require('./topMenu');

PageBase = React.createClass({
  displayName: "PageBase",
  propTypes: {
    user: React.PropTypes.object
  },
  render: function() {
    return div({
      className: "container"
    }, TopMenu({
      user: this.props.user
    }), this.props.children);
  }
});

module.exports = PageBase;

},{"./topMenu":7}],5:[function(require,module,exports){
var CountDown, React, SetIntervalMixin, div, label, script, span, _ref;

React = window.React;

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

},{"../mixins/interval":3}],6:[function(require,module,exports){
var FlipClock, React, div, label, script, span, _ref;

React = window.React;

_ref = React.DOM, div = _ref.div, script = _ref.script, label = _ref.label, span = _ref.span;

FlipClock = function(args) {
  return div({
    className: "text-center",
    dangerouslySetInnerHTML: {
      __html: "<div class=\"clock text-center\" style=\"margin:2em;\"></div>\n<script type=\"text/javascript\">\n    window.queue.push(function(){\n        var clock;\n        $(document).ready(function() {\n            var currentDate = new Date();\n            var futureDate  = new Date(\"" + args.target_date + "\");\n            var diff = (futureDate.getTime() / 1000 -\n                        currentDate.getTime() / 1000);\n            if (diff < 0){\n                diff = 0;\n            }\n            clock = $('.clock').FlipClock(diff, {\n                clockFace: 'DailyCounter',\n                countdown: true\n            });\n        });\n    });\n</script>"
    }
  });
};

module.exports = FlipClock;

},{}],7:[function(require,module,exports){
var React, TopMenu, a, div, li, span, ul, _ref;

React = window.React;

_ref = React.DOM, div = _ref.div, a = _ref.a, ul = _ref.ul, li = _ref.li, span = _ref.span;

TopMenu = React.createClass({
  displayName: "TopMenu",
  propTypes: {
    user: React.PropTypes.object
  },
  renderAuth: function() {
    return div({
      className: "text-right"
    }, ul({
      className: "list-inline top-menu"
    }, li({
      className: "top-menu-item"
    }, span({
      className: "glyphicon glyphicon-home",
      style: {
        "margin-right": "5px"
      }
    }), a({
      href: "/",
      className: "color-default"
    }, "Home")), li({
      className: "top-menu-item"
    }, span({
      className: "glyphicon glyphicon-th-list",
      style: {
        "margin-right": "5px"
      }
    }), a({
      href: "/my_events",
      className: "color-default"
    }, "My events")), li({
      className: "top-menu-item"
    }, a({
      className: "btn btn-success btn-xs",
      href: "/create_event"
    }, "Create new event"))));
  },
  renderUnAuth: function() {
    return div({
      className: "text-right"
    }, a({
      href: "/create_event"
    }, "Authorize and create event"));
  },
  render: function() {
    if (this.props.user) {
      return this.renderAuth();
    } else {
      return this.renderUnAuth();
    }
  }
});

module.exports = TopMenu;

},{}]},{},[1])