/** @jsx React.DOM */
var React = require('react');


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


