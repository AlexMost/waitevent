var MyEventsListPage, UserEvent, reactRender;

UserEvent = require('../models/userEvent');

MyEventsListPage = require('../../components/my_events_list_page');

reactRender = require('../react_render').reactRender;

exports.my_events_get = function(req, res) {
  return UserEvent.find({
    userId: req.user._id,
    status: 1
  }).sort("-createdAt").exec(function(err, events) {
    return reactRender(res, MyEventsListPage, {
      user: req.user,
      events: events
    }, {
      initScript: './js/my_events_list_page.js',
      css: './css/pages/my_events_list.css'
    });
  });
};
