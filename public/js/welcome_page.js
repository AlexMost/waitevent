(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var React, WelcomePageComponent, componentData, mountNode;

React = window.React;

WelcomePageComponent = require('../components/welcome_page');

mountNode = document.getElementById("react-main-mount");

componentData = JSON.parse((document.getElementById("componentData")).innerHTML);

React.renderComponent(new WelcomePageComponent(componentData), mountNode);

},{"../components/welcome_page":4}],2:[function(require,module,exports){
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

},{"./topMenu":3}],3:[function(require,module,exports){
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

},{}],4:[function(require,module,exports){
var PageBase, React, WelcomePage, a, button, div, h1, _ref;

React = window.React;

_ref = React.DOM, div = _ref.div, h1 = _ref.h1, a = _ref.a, button = _ref.button;

PageBase = require('./portlets/base');

WelcomePage = React.createClass({
  displayName: "WelcomePage",
  propTypes: {
    user: React.PropTypes.object
  },
  render: function() {
    var create_link_url;
    create_link_url = this.props.user ? "/create_event" : "/auth/google?r=/create_event";
    return PageBase({
      user: this.props.user
    }, div({
      className: "row"
    }, div({
      className: "col-md-12"
    }, h1({
      className: "text-center",
      style: {
        "margin-top": "20%"
      }
    }, "Create countdown for some event:"))), div({
      className: "row"
    }, div({
      className: "col-md-12 text-center"
    }, a({
      href: create_link_url,
      className: "btn btn-success btn-lg",
      style: {
        "margin-top": "5%"
      }
    }, "Create"))));
  }
});

module.exports = WelcomePage;

},{"./portlets/base":2}]},{},[1])