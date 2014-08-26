/** @jsx React.DOM */
var React = require('react');


module.exports = function(props, content) {
    return (
		<div id="myModal" className="modal fade">
		  <div className="modal-dialog">
		    <div className="modal-content">
		      <div className="modal-header">
		        <button type="button" className="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span className="sr-only">Close</span></button>
		        <h4 className="modal-title">{props.title}</h4>
		      </div>
		      <div className="modal-body">
		        {content}
		      </div>
		      <div className="modal-footer">
		        <button type="button" className="btn btn-default" data-dismiss="modal">Cancel</button>
		        <button type="button" onClick={props.onConfirm} className="btn btn-primary">Ok</button>
		      </div>
		    </div>
		  </div>
		</div>
    )
}