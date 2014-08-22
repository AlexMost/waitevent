/** @jsx React.DOM */
var React = require('react');


module.exports = function(args) {
    return (
    <div id="myModal" className="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
      <div className="modal-dialog modal-lg">
        <div className="modal-content">
          args.content
        </div>
      </div>
    </div>
    )
}