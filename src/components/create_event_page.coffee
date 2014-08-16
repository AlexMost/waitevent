React = require 'react'
{div, h1, a, form, script} = React.DOM
PageBase = require './portlets/base'
{HorizontalFormInputText, HorizontalFormTextArea} = require './portlets/form'
{DateTimePicker} = require './portlets/datetime_picker'



CreateEventPage = React.createClass
    displayName: "CreateEventPage"

    propTypes:
        user: React.PropTypes.object

    render: ->
        # datetimePicker = React.renderComponentToString DateTimePicker()

        PageBase {user: @props.user},
            h1 {className: "text-center"}, "Enter some event data:"

            form {className: "form-horizontal", role: "form"},
                HorizontalFormInputText
                    key: "titleinput"
                    label: "Title"
                    placeholder: "Enter your event title"

                HorizontalFormTextArea
                    key: "description"
                    label: "Description"
                    placeholder: "Enter some event description"

                DateTimePicker
                    key: "datetimepicker"
                    label: "Date time"
                    placeholder: "select event date time"


module.exports = CreateEventPage