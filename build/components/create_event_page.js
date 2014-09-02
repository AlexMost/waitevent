var CreateEventPage, DateTimePicker, HorizontalFormInputText, HorizontalFormSubmit, HorizontalFormTextArea, PageBase, React, a, div, form, h1, script, _ref, _ref1;

React = require('react');

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
