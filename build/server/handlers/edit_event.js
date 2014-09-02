var CreateEventPage, UserEvent, reactRender, validate_ev_from_req;

CreateEventPage = require('../../components/create_event_page');

UserEvent = require('../models/userEvent');

reactRender = require('../react_render').reactRender;

validate_ev_from_req = require('./create_event').validate_ev_from_req;

exports.edit_event_get = function(req, res) {
  return UserEvent.findOne({
    _id: req.params.eventId
  }, function(err, event) {
    if (!event) {
      return res.send(404);
    }
    return reactRender(res, CreateEventPage, {
      edit: true,
      user: req.user,
      formData: event
    }, {
      initScript: '/js/create_event_page.js'
    });
  });
};

exports.edit_event_post = function(req, res) {
  var user;
  user = req.user;
  return UserEvent.findOne({
    _id: req.params.eventId
  }, function(err, event) {
    var errors;
    if (!event) {
      return res.send(404);
    }
    if (event.userId === user._id) {
      return res.send(404);
    }
    errors = validate_ev_from_req(req);
    if (errors) {
      return reactRender(res, CreateEventPage({
        edit: true,
        user: req.user,
        errors: errors || {},
        formData: req.body
      }), {
        initScript: '/js/create_event_page.js'
      });
    } else {
      event.title = req.body.title;
      event.description = req.body.description;
      event.deadLine = req.body.deadLine;
      return event.save(function(err, event) {
        return res.redirect("/event/" + event._id);
      });
    }
  });
};

exports.delete_event = function(req, res) {
  var user;
  user = req.user;
  return UserEvent.findOne({
    _id: req.params.eventId
  }, function(err, event) {
    if (!event) {
      return res.send(404);
    }
    if (event.userId === user._id) {
      return res.send(404);
    }
    event.status = 3;
    return event.save(function(err, event) {
      return res.json({
        status: "ok",
        action: "deleted",
        event: event
      });
    });
  });
};
