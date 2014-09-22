React = require 'react'
{div, script, label, span} = React.DOM


exports.DateTimePicker = (args) ->
    div
        className: "form-group #{'has-error' if args.error}"
        label
            htmlFor: args.key + "_id"
            className: "col-sm-4 control-label"
            args.label
        div
            className: "col-sm-3"
            div
                id:"datetimepicker1"
                className: "input-group date"
                dangerouslySetInnerHTML: {__html: """
                    <input id="#{args.key + "_id"}"
                           type="text"
                           name="#{args.name}"
                           placeholder="#{args.placeholder or ''}"
                           class="form-control" />
                    <span class="input-group-addon">
                        <span class="glyphicon-calendar glyphicon">
                        </span>
                    </span>
                    """}
            span {className: "help-block text-right"}, args.error or ""

        script
            dangerouslySetInnerHTML: {__html: """
                window.queue.push(function(){
                    $(function() {
                        $('#datetimepicker1').datetimepicker(
                            {language: 'pt-BR'});
                        $('#datetimepicker1').data('DateTimePicker').setDate(new Date("#{args.value}"));
                    });
                });
                """}






