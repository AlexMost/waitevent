UserEvent = require '../models/userEvent'
MyEventsListPage = require '../../components/my_events_list_page'
{reactRender} = require '../react_render'


exports.my_events_get = (req, res) ->
    UserEvent.find({userId: req.user._id, status: 1})
        .sort("-createdAt")
        .exec((err, events) ->
            reactRender(
                res
                MyEventsListPage
                {user: req.user, events}
                {
                    initScript: './js/my_events_list_page.js'
                    css: './css/pages/my_events_list.css'
                }
            )
    )
