var React, div, label, script, span, _ref;

React = require('react');

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
