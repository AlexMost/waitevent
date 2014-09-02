var CountDown, EventListItem, EventsGroup, EventsItemToolbar, Modal, MyEventsEventsListPage, PageBase, React, a, b, div, getEventsGroups, h1, li, p, small, span, ul, _ref;

React = require('react');

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
