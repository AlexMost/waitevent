var React, reactRender, sanitizeOutputJson;

React = require('react');

sanitizeOutputJson = function(raw_json) {
  return raw_json.replace(/</g, "&lt;").replace(/>/g, "&gt;");
};

reactRender = function(res, componentClass, props, templateProps) {
  var component, str;
  component = new componentClass(props);
  str = React.renderComponentToString(component);
  templateProps['reactOutput'] = str;
  templateProps['componentData'] = sanitizeOutputJson(JSON.stringify(props));
  return res.render('layout', templateProps);
};

module.exports = {
  reactRender: reactRender
};
