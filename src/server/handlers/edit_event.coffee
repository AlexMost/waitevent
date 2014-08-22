CreateEventPage = require '../../components/create_event_page'
UserEvent = require '../models/userEvent'
{reactRender} = require '../react_render'
{validate_event_from_req} = require './create_event'


exports.edit_event_get = (req, res) ->
    UserEvent.findOne {_id: req.params.eventId}, (err, event) ->
        return res.send(404) unless event

        reactRender(
            res
            CreateEventPage
            {edit: true, user: req.user, formData: event}
            {initScript: '/js/create_event_page.js'}
        )


exports.edit_event_post = (req, res) ->
    user = req.user
    UserEvent.findOne {_id: req.params.eventId}, (err, event) ->
        return res.send(404) unless event
        return res.send(404) unless event.userId != user._id

        errors = validate_event_from_req req

        if errors
            reactRender(
                res
                CreateEventPage
                    edit: true
                    user: req.user
                    errors: errors or {}
                    formData: req.body
                {initScript: '/js/create_event_page.js'}
            )
        else
            event.title = req.body.title
            event.description = req.body.description
            event.deadLine = req.body.deadLine

            event.save (err, event) ->
                # TODO: handle error
                res.redirect "/event/#{event._id}"