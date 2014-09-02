(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var CreateEventPage, React, componentData, mountNode;

React = window.React;

CreateEventPage = require('../components/create_event_page');

mountNode = document.getElementById("react-main-mount");

componentData = JSON.parse((document.getElementById("componentData")).innerHTML);

React.renderComponent(new CreateEventPage(componentData), mountNode);

},{"../components/create_event_page":2}],2:[function(require,module,exports){
var CreateEventPage, DateTimePicker, HorizontalFormInputText, HorizontalFormSubmit, HorizontalFormTextArea, PageBase, React, a, div, form, h1, script, _ref, _ref1;

React = window.React;

_ref = React.DOM, div = _ref.div, h1 = _ref.h1, a = _ref.a, form = _ref.form, script = _ref.script;

PageBase = require('./portlets/base');

_ref1 = require('./portlets/form'), HorizontalFormInputText = _ref1.HorizontalFormInputText, HorizontalFormTextArea = _ref1.HorizontalFormTextArea, HorizontalFormSubmit = _ref1.HorizontalFormSubmit;

DateTimePicker = require('./portlets/datetime_picker').DateTimePicker;

CreateEventPage = React.createClass({
  displayName: "CreateEventPage",
  propTypes: {
    user: React.PropTypes.object,
    errors: React.PropTypes.object,
    formData: React.PropTypes.object,
    edit: React.PropTypes.bool
  },
  getDefaultProps: function() {
    return {
      errors: {},
      formData: {},
      edit: false
    };
  },
  render: function() {
    var d, deadLine, submitButtonText, _ref2, _ref3, _ref4;
    deadLine = (this.props.formData.deadLine ? new Date(this.props.formData.deadLine) : (d = new Date(Date.now()), d.setHours(d.getHours() + 1), d)).toLocaleString();
    submitButtonText = this.props.edit ? "Edit event" : "Create event";
    return PageBase({
      user: this.props.user
    }, h1({
      className: "text-center"
    }, "Enter some event data:"), form({
      className: "form-horizontal",
      role: "form",
      method: "POST"
    }, HorizontalFormInputText({
      key: "titleinput",
      label: "Title",
      name: "title",
      value: this.props.formData.title,
      error: (_ref2 = this.props.errors.title) != null ? _ref2.msg : void 0,
      placeholder: "Enter your event title"
    }), HorizontalFormTextArea({
      key: "description",
      label: "Description",
      name: "description",
      value: this.props.formData.description,
      error: (_ref3 = this.props.errors.description) != null ? _ref3.msg : void 0,
      placeholder: "Enter some event description"
    }), DateTimePicker({
      key: "datetimepicker",
      label: "Date time",
      name: "deadLine",
      value: deadLine,
      error: (_ref4 = this.props.errors.deadLine) != null ? _ref4.msg : void 0,
      placeholder: "Select event date time"
    }), HorizontalFormSubmit({
      key: "submitbtn",
      text: submitButtonText
    })));
  }
});

module.exports = CreateEventPage;

},{"./portlets/base":3,"./portlets/datetime_picker":4,"./portlets/form":5}],3:[function(require,module,exports){
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

},{"./topMenu":6}],4:[function(require,module,exports){
var React, div, label, script, span, _ref;

React = window.React;

_ref = React.DOM, div = _ref.div, script = _ref.script, label = _ref.label, span = _ref.span;

exports.DateTimePicker = function(args) {
  return div({
    className: "form-group " + (args.error ? 'has-error' : void 0)
  }, label({
    htmlFor: args.key + "_id",
    className: "col-sm-2 control-label"
  }, args.label), div({
    className: "col-sm-10"
  }, div({
    id: "datetimepicker1",
    className: "input-group date",
    dangerouslySetInnerHTML: {
      __html: "<input id=\"" + (args.key + "_id") + "\"\n       type=\"text\"\n       name=\"" + args.name + "\"\n       placeholder=\"" + (args.placeholder || '') + "\"\n       value=\"" + (args.value || '') + "\"\n       class=\"form-control\" />\n<span class=\"input-group-addon\">\n    <span class=\"glyphicon-calendar glyphicon\">\n    </span>\n</span>"
    }
  }), span({
    className: "help-block text-right"
  }, args.error || "")), script({
    dangerouslySetInnerHTML: {
      __html: "window.queue.push(function(){\n    $(function() {\n        $('#datetimepicker1').datetimepicker(\n            {language: 'pt-BR'});\n    });\n});"
    }
  }));
};

},{}],5:[function(require,module,exports){
/** @jsx React.DOM */
var React = window.React;


exports.HorizontalFormInputText = function(args) {
    var groupCls = "form-group";
    if (args.error) {
        groupCls += " has-error"
    }

	return (
  		React.DOM.div({className: groupCls, key: args.key}, 
    		React.DOM.label({htmlFor: args.key + "id", className: "col-sm-2 control-label"}, args.label), 
    		React.DOM.div({className: "col-sm-10"}, 
      		React.DOM.input({
      			id: args.key + "id", 
      			type: args.type || 'text', 
      			className: "form-control", 
                name: args.name, 
                defaultValue: args.value || "", 
      			placeholder: args.placeholder}), 
                React.DOM.span({className: "help-block text-right"}, args.error || "")
    		)
  		)
	)
};


exports.HorizontalFormTextArea = function(args) {
    var groupCls = "form-group";
    if (args.error) {
        groupCls += " has-error"
    }

	return (
		React.DOM.div({className: groupCls, key: args.key}, 
    		React.DOM.label({htmlFor: args.key + "_id", className: "col-sm-2 control-label"}, args.label), 
    		React.DOM.div({className: "col-sm-10"}, 
				React.DOM.textarea({
					id: args.key + "id", 
					className: "form-control", 
					placeholder: args.placeholder, 
                    name: args.name, 
					rows: "3", 
                    defaultValue: args.value || ""
                    }
				), 
                React.DOM.span({className: "help-block text-right"}, args.error || "")
			)
		)
	)
};


exports.HorizontalFormSubmit = function(args) {
	return (
		React.DOM.div({className: "form-group", key: args.key}, 
    		React.DOM.div({className: "col-sm-offset-2 col-sm-10"}, 
      			React.DOM.button({type: "submit", className: "btn btn-primary"}, args.text)
    		)
  		)
	)
};



},{}],6:[function(require,module,exports){
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