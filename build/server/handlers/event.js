var CreateEventPage, EventViewPage, UserEvent, reactRender, validate_ev_from_req;

CreateEventPage = require('../../components/create_event_page');

EventViewPage = require('../../components/event_view_page');

UserEvent = require('../models/userEvent');

reactRender = require('../react_render').reactRender;

validate_ev_from_req = function(req) {
  req.checkBody('title', "Title param is required").notEmpty();
  req.checkBody('deadLine', "Select events date and time").isDate();
  return req.validationErrors(true);
};

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

exports.create_event_get = function(req, res) {
  return reactRender(res, CreateEventPage, {
    user: req.user
  }, {
    initScript: '/js/create_event_page.js'
  });
};

exports.create_event_post = function(req, res) {
  var errors, newEvent;
  console.log(validate_ev_from_req);
  errors = validate_ev_from_req(req);
  if (errors) {
    return reactRender(res, CreateEventPage, {
      user: req.user,
      errors: errors || {},
      formData: req.body
    }, {
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
