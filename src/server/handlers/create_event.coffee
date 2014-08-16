CreateEventPage = require '../../components/create_event_page'
UserEvent = require '../models/userEvent'
{reactRender} = require '../react_render'

exports.create_event_get = (req, res) ->
    reactRender(
        res
        CreateEventPage
        {user: req.user}
        {initScript: '/js/create_event_page.js'}
    )


exports.create_event_post = (req, res) ->
    req.checkBody('title', "Title param is required").notEmpty()
    req.checkBody(
        'deadline',
        "Select events date and time").isDate()
    errors = req.validationErrors(true)

    if errors
        reactRender(
            res
            CreateEventPage
            {
                user: req.user
                errors: errors or {}
                formData: req.body
            }
            {initScript: '/js/create_event_page.js'}
        )
    else
        newEvent = new UserEvent(
            title: req.body.title
            description: req.body.description
            deadLine: req.body.deadline
            userId: req.user._id
        )

        newEvent.save (err, event) ->
            # TODO: handle error
            res.redirect "/event/#{event._id}"