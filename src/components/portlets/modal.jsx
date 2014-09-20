/** @jsx React.DOM */
var React = require('react');


var Modal = React.createClass({
	displayName: "Modal",
	getDefaultProps: function(){
		return {
			onConfirm: function(){},
			skipButtons: false,
			width: "500px"
		}
	},
	show: function(){
		$(this.getDOMNode()).modal();
	},
	hide: function(){
		$(this.getDOMNode()).modal('hide');	
	},
	confirm: function(){
		this.props.onConfirm()
		this.hide()
	},
	render: function(){
		footer = null
		if (!this.props.skipButtons) {
			footer = (
				<div className="modal-footer">
			        <button type="button" className="btn btn-default" data-dismiss="modal">
			        	Cancel
			        </button>
			        <button type="button" onClick={this.confirm} className="btn btn-primary">
			        	Ok
			        </button>
		    	</div>
		    )
		}

		return (
			<div className="modal fade">
			  <div className="modal-dialog" style={{width: this.props.width}}>
			    <div className="modal-content">
			      <div className="modal-header">
			        <button type="button" className="close" data-dismiss="modal">
				        <span aria-hidden="true">&times;</span>
				        <span className="sr-only">Close</span>
			        </button>
			        <h4 className="modal-title text-center">{this.props.title}</h4>
			      </div>
			      <div className="modal-body">
			        {this.props.children}
			      </div>
			      {footer}
			    </div>
			  </div>
			</div>
    	)
	}
});


module.exports = Modal