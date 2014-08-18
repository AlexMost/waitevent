UserEvent = require '../models/userEvent'
MyEventsListPage = require '../../components/my_events_list_page'
{reactRender} = require '../react_render'


exports.my_events_get = (req, res) ->
    UserEvent.find({userId: req.user._id})
        .sort("-createdAt")
        .exec((err, events) ->
            reactRender(
                res
                MyEventsListPage
                {user: req.user, events}
                {initScript: './js/my_events_list_page.js'}
            )
    )
