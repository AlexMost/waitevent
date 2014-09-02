var CreateEventPage, UserEvent, reactRender, validate_ev_from_req;

CreateEventPage = require('../../components/create_event_page');

UserEvent = require('../models/userEvent');

reactRender = require('../react_render').reactRender;

validate_ev_from_req = function(req) {
  req.checkBody('title', "Title param is required").notEmpty();
  req.checkBody('deadLine', "Select events date and time").isDate();
  return req.validationErrors(true);
};

exports.create_event_get = function(req, res) {
  return reactRender(res, CreateEventPage, {
    user: req.user
  }, {
    initScript: '/js/create_event_page.js'
  });
};

exports.create_event_post = function(req, res) {
  var errors, newEvent;
  errors = validate_ev_from_req(req);
  if (errors) {
    return reactRender(res, CreateEventPage({
      user: req.user,
      errors: errors || {},
      formData: req.body
    }), {
      initScript: '/js/create_event_page.js'
    });
  } else {
    newEvent = new UserEvent({
      title: req.body.title,
      description: req.body.description,
      deadLine: req.body.deadLine,
      userId: req.user._id
    });
    return newEvent.save(function(err, event) {
      return res.redirect("/event/" + event._id);
    });
  }
};

exports.validate_ev_from_req = validate_ev_from_req;
