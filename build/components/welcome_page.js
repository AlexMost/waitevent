var PageBase, React, WelcomePage, a, button, div, h1, _ref;

React = require('react');

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
