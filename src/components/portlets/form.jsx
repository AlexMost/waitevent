/** @jsx React.DOM */
var React = require('react');


exports.HorizontalFormInputText = function(args) {
    var groupCls = "form-group";
    if (args.error) {
        groupCls += " has-error"
    }

	return (
  		<div className={groupCls} key={args.key} >
    		<label htmlFor={args.key + "id"} className="col-sm-4 control-label">{args.label}</label>
    		<div className="col-sm-4">
      		<input
      			id={args.key + "id"}
      			type={args.type || 'text'} 
      			className="form-control"
                name={args.name}
                defaultValue={args.value || ""}
      			placeholder={args.placeholder}/>
                <span className="help-block text-right">{args.error || ""}</span>
    		</div>
  		</div>
	)
};


exports.HorizontalFormTextArea = function(args) {
    var groupCls = "form-group";
    if (args.error) {
        groupCls += " has-error"
    }

	return (
		<div className={groupCls} key={args.key} >
    		<label htmlFor={args.key + "_id"} className="col-sm-4 control-label">{args.label}</label>
    		<div className="col-sm-4">
				<textarea
					id={args.key + "id"}
					className="form-control" 
					placeholder={args.placeholder}
                    name={args.name}
					rows="6"
                    defaultValue={args.value || ""}
                    >
				</textarea>
                <span className="help-block text-right">{args.error || ""}</span>
			</div>
		</div>
	)
};


exports.HorizontalFormSubmit = function(args) {
	return (
		<div className="form-group" key={args.key}>
    		<div className="col-sm-12 text-center">
      			<button type="submit" className="btn btn-primary btn-lg">{args.text}</button>
    		</div>
  		</div>
	)
};

exports.HorizontalFormCustomField = function(args, content) {
  return (
    <div className="form-group" key={args.key} >
        <label htmlFor={args.key + "_id"} className="col-sm-4 control-label">{args.label}</label>
        <div className="col-sm-4">
          {content}
        </div>
      </div>
  )
}


