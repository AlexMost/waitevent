React = require 'react'
{div, script, label} = React.DOM


exports.DateTimePicker = (args) ->
    div
        className: "form-group"
        label
            htmlFor: args.key + "_id"
            className: "col-sm-2 control-label"
            args.label
        div
            className: "col-sm-10"
            dangerouslySetInnerHTML: {__html: """
                <div class="input-group date" id="datetimepicker1">
                    <input id="#{args.key + "_id"}"
                           type="text"
                           placeholder="#{args.placeholder or ''}"
                           class="form-control" />
                    <span class="input-group-addon">
                        <span class="glyphicon-calendar glyphicon">
                        </span>
                    </span>
                </div>
                """}

        script
            dangerouslySetInnerHTML: {__html: """
                window.queue.push(function(){
                    $(function() {
                        $('#datetimepicker1').datetimepicker(
                            {language: 'pt-BR'});
                    });
                });
                """}






