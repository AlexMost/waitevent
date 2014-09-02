var PageBase, React, TopMenu, div;

React = require('react');

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
