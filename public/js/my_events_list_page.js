(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var MyEventsListPage, React, componentData, mountNode;

React = window.React;

MyEventsListPage = require('../components/my_events_list_page');

mountNode = document.getElementById("react-main-mount");

componentData = JSON.parse((document.getElementById("componentData")).innerHTML);

React.renderComponent(new MyEventsListPage(componentData), mountNode);

},{"../components/my_events_list_page":3}],2:[function(require,module,exports){
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

},{}],3:[function(require,module,exports){
var CountDown, EventListItem, EventsGroup, EventsItemToolbar, Modal, MyEventsEventsListPage, PageBase, React, a, b, div, getEventsGroups, h1, li, p, small, span, ul, _ref;

React = window.React;

_ref = React.DOM, div = _ref.div, h1 = _ref.h1, p = _ref.p, ul = _ref.ul, li = _ref.li, span = _ref.span, a = _ref.a, b = _ref.b, small = _ref.small;

PageBase = require('./portlets/base');

CountDown = require('./portlets/countdown');

Modal = require('./portlets/modal');

getEventsGroups = function(events) {
  var d, e, groups, sort_events, sorted_events, to_groups;
  to_groups = function(res, ev) {
    var date;
    date = (new Date(ev.createdAt)).toLocaleDateString();
    if (!(date in res)) {
      res[date] = {
        date: date,
        events: [ev]
      };
    } else {
      res[date].events.push(ev);
    }
    return res;
  };
  groups = events.reduce(to_groups, {});
  sort_events = function(ev1, ev2) {
    return (new Date(ev2)) - (new Date(ev1));
  };
  sorted_events = (function() {
    var _results;
    _results = [];
    for (d in groups) {
      e = groups[d];
      _results.push([d, e.events.sort(sort_events)]);
    }
    return _results;
  })();
  return sorted_events.sort(function(_arg, _arg1) {
    var d1, d2;
    d1 = _arg[0];
    d2 = _arg1[0];
    return d1 - d2;
  });
};

EventsItemToolbar = React.createClass({
  displayName: "EventsItemToolbar",
  getDefaultProps: function() {
    return {
      onDelete: function() {}
    };
  },
  render: function() {
    return div({}, a({
      ref: 'edit_btn',
      href: "/edit_event/" + this.props.event._id,
      title: "Edit event",
      className: "color-default",
      onMouseEnter: (function(_this) {
        return function() {
          return $(_this.refs.edit_btn.getDOMNode()).tooltip();
        };
      })(this)
    }, span({
      className: "glyphicon glyphicon-pencil toolbar-icon"
    })), a({
      href: "#",
      ref: "del_btn",
      onClick: (function(_this) {
        return function(ev) {
          ev.preventDefault();
          return _this.props.onDelete(_this.props.event);
        };
      })(this),
      title: "Remove this event",
      className: "color-default",
      onMouseEnter: (function(_this) {
        return function() {
          return $(_this.refs.del_btn.getDOMNode()).tooltip();
        };
      })(this)
    }, span({
      className: "glyphicon glyphicon-remove toolbar-icon"
    })));
  }
});

EventListItem = React.createClass({
  displayName: "EventListItem",
  getDefaultProps: function() {
    return {
      onDelete: function() {}
    };
  },
  render: function() {
    var date, target_date;
    date = new Date(this.props.event.createdAt);
    target_date = new Date(this.props.event.deadLine);
    return div({
      className: "panel panel-default box-shadow"
    }, div({
      className: "panel-heading"
    }, div({
      className: "row"
    }, div({
      className: "col-md-11"
    }, b({}, a({
      href: "/event/" + this.props.event._id
    }, span({
      className: "event-title"
    }, this.props.event.title)), span({
      className: "countdown"
    }, new CountDown({
      target_date: target_date
    })))), div({
      className: "col-md-1 text-center"
    }, new EventsItemToolbar({
      event: this.props.event,
      onDelete: this.props.onDelete
    })))), div({
      className: "panel-body"
    }, p({}, this.props.event.description)));
  }
});

EventsGroup = React.createClass({
  displayName: "EventsGroup",
  getDefaultProps: function() {
    return {
      onDelte: function() {}
    };
  },
  propTypes: {
    events: React.PropTypes.array
  },
  render: function() {
    return ul({
      className: "list-unstyled"
    }, this.props.events.map((function(_this) {
      return function(event) {
        return li({
          key: event._id
        }, new EventListItem({
          event: event,
          onDelete: _this.props.onDelete
        }));
      };
    })(this)));
  }
});

MyEventsEventsListPage = React.createClass({
  displayName: "MyEventsEventsListPage",
  propTypes: {
    events: React.PropTypes.array,
    user: React.PropTypes.object
  },
  getInitialState: function() {
    return {
      groups: [],
      delItem: {}
    };
  },
  render: function() {
    return PageBase({
      user: this.props.user
    }, h1({
      style: {
        "margin-bottom": "5%"
      }
    }, "My events"), this.props.events.length > 0 ? div({}, new EventsGroup({
      events: this.props.events,
      onDelete: (function(_this) {
        return function(event) {
          return _this.setState({
            delItem: event
          }, function() {
            return $("#myModal").modal();
          });
        };
      })(this)
    }), Modal({
      title: "Confirm delete",
      onConfirm: (function(_this) {
        return function() {
          $.ajax({
            type: "POST",
            url: "/delete_event/" + _this.state.delItem._id,
            data: {},
            success: function() {
              var newEvents;
              newEvents = _this.props.events.filter(function(ev) {
                return ev._id !== _this.state.delItem._id;
              });
              return _this.setProps({
                events: newEvents
              });
            }
          });
          return $("#myModal").modal('hide');
        };
      })(this)
    }, div({}, "Delete item " + this.state.delItem.title + "?"))) : div({}, div({}, "You have no events yet"), div({}, a({
      href: "/create_event",
      className: "btn btn-success btn-lg",
      style: {
        "margin-top": "5%"
      }
    }, "Create first event"))));
  }
});

module.exports = MyEventsEventsListPage;

},{"./portlets/base":4,"./portlets/countdown":5,"./portlets/modal":6}],4:[function(require,module,exports){
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

},{"../mixins/interval":2}],6:[function(require,module,exports){
/** @jsx React.DOM */
var React = window.React;


module.exports = function(props, content) {
    return (
		React.DOM.div({id: "myModal", className: "modal fade"}, 
		  React.DOM.div({className: "modal-dialog"}, 
		    React.DOM.div({className: "modal-content"}, 
		      React.DOM.div({className: "modal-header"}, 
		        React.DOM.button({type: "button", className: "close", 'data-dismiss': "modal"}, React.DOM.span({'aria-hidden': "true"}, "×"), React.DOM.span({className: "sr-only"}, "Close")), 
		        React.DOM.h4({className: "modal-title"}, props.title)
		      ), 
		      React.DOM.div({className: "modal-body"}, 
		        content
		      ), 
		      React.DOM.div({className: "modal-footer"}, 
		        React.DOM.button({type: "button", className: "btn btn-default", 'data-dismiss': "modal"}, "Cancel"), 
		        React.DOM.button({type: "button", onClick: props.onConfirm, className: "btn btn-primary"}, "Ok")
		      )
		    )
		  )
		)
    )
}
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