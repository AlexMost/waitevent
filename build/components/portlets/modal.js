/** @jsx React.DOM */
var React = require('react');


module.exports = function(props, content) {
    return (
		React.DOM.div({id: "myModal", className: "modal fade"}, 
		  React.DOM.div({className: "modal-dialog"}, 
		    React.DOM.div({className: "modal-content"}, 
		      React.DOM.div({className: "modal-header"}, 
		        React.DOM.button({type: "button", className: "close", 'data-dismiss': "modal"}, React.DOM.span({'aria-hidden': "true"}, "×"), React.DOM.span({className: "sr-only"}, "Close")), 
		        React.DOM.h4({className: "modal-title"}, props.title)
		      ), 
		      React.DOM.div({className: "modal-body"}, 
		        content
		      ), 
		      React.DOM.div({className: "modal-footer"}, 
		        React.DOM.button({type: "button", className: "btn btn-default", 'data-dismiss': "modal"}, "Cancel"), 
		        React.DOM.button({type: "button", onClick: props.onConfirm, className: "btn btn-primary"}, "Ok")
		      )
		    )
		  )
		)
    )
}