var EventViewPage, UserEvent, reactRender;

UserEvent = require('../models/userEvent');

reactRender = require('../react_render').reactRender;

EventViewPage = require('../../components/event_view_page');

exports.event_view_get = function(req, res) {
  return UserEvent.findOne({
    _id: req.params.eventId
  }, function(err, event) {
    if (!event) {
      return res.send(404);
    }
    return reactRender(res, EventViewPage, {
      user: req.user,
      event: event
    }, {
      initScript: '/js/event_view_page.js'
    });
  });
};
