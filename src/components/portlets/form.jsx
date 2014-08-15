/** @jsx React.DOM */
var React = require('react');

exports.HorizontalForm = function(components) {
	return (
		<form className="form-horizontal" role="form">
			{components}
		</form>
	)
}

exports.HorizontalFormInputText = function(args) {
	return (
  		<div className="form-group" key={args.key} >
    		<label htmlFor={args.key + "id"} className="col-sm-2 control-label">{args.label}</label>
    		<div className="col-sm-10">
      		<input
      			id={args.key + "id"}
      			type={args.type || 'text'} 
      			className="form-control" 
      			placeholder={args.placeholder}/>
    		</div>
  		</div>
	)
}

exports.HorizontalFormTextArea = function(args) {
	return (
		<div className="form-group" key={args.key} >
    		<label htmlFor={args.key + "_id"} className="col-sm-2 control-label">{args.label}</label>
    		<div className="col-sm-10">
				<textarea
					id={args.key + "id"}
					className="form-control" 
					placeholder={args.placeholder}
					rows="3">
					{args.text}
				</textarea>
			</div>
		</div>
	)
}
