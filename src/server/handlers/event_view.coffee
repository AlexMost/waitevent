UserEvent = require '../models/userEvent'
{reactRender} = require '../react_render'
EventViewPage = require '../../components/event_view_page'


exports.event_view_get = (req, res) ->
    UserEvent.findOne {_id: req.params.eventId}, (err, event) ->
        return res.send(404) unless event

        reactRender(
            res
            EventViewPage
            {user: req.user, event}
            {
                initScript: '/js/event_view_page.js'
                css: '/css/event_view.css'
            }
        )