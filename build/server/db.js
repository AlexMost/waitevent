var init_db, mongoose;

mongoose = require('mongoose');

init_db = function(connection_string) {
  var db;
  mongoose.connect(connection_string);
  db = mongoose.connection;
  db.on('error', console.error.bind(console, 'connection error:'));
  db.on('open', function() {
    return console.log('db connected successfully');
  });
  require('./models/user');
  return require('./models/userEvent');
};

module.exports = {
  init_db: init_db
};
