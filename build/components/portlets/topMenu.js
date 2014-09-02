var React, TopMenu, a, div, li, span, ul, _ref;

React = require('react');

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
