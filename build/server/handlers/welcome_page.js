var WelcomePage, reactRender;

WelcomePage = require('../../components/welcome_page');

reactRender = require('../react_render').reactRender;

exports.welcome_page_get = function(req, res) {
  return reactRender(res, WelcomePage, {
    user: req.user
  }, {
    initScript: '/js/welcome_page.js'
  });
};
