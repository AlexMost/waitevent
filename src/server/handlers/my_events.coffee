UserEvent = require '../models/userEvent'

exports.my_events_get = (req, res) ->
    UserEvent.find {userId: req.user._id}, (err, users) ->
        res.json(users)
