/** @jsx React.DOM */
var React = require('react');


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


exports.HorizontalFormSubmit = function(args) {
	return (
		<div className="form-group" key={args.key}>
    		<div className="col-sm-offset-2 col-sm-10">
      			<button type="submit" className="btn btn-primary">{args.text}</button>
    		</div>
  		</div>
	)
}


