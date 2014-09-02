var EVENT_STATUSES, ObjectId, Schema, UserEvent, eventSchema, mongoose;

mongoose = require('mongoose');

Schema = mongoose.Schema;

ObjectId = Schema.ObjectId;

EVENT_STATUSES = {
  ACTIVE: 1,
  CLOSED: 2,
  DELETED: 3,
  HIDDEN: 4
};

eventSchema = Schema({
  title: String,
  description: String,
  createdAt: {
    type: Date,
    "default": Date.now
  },
  deadLine: {
    type: Date
  },
  userId: {
    type: ObjectId,
    ref: "User"
  },
  status: {
    type: Number,
    "default": EVENT_STATUSES.ACTIVE
  }
});

UserEvent = mongoose.model("UserEvent", eventSchema);

module.exports = UserEvent;
