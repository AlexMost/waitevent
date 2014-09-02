var FlipClock, React, div, label, script, span, _ref;

React = require('react');

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
