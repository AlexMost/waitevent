WelcomePage = require '../../components/welcome_page'
{reactRender} = require '../react_render'


exports.welcome_page_get = (req, res) ->
    reactRender(
        res
        WelcomePage
        {user: req.user}
        {
            initScript: '/js/welcome_page.js'
            title: "wait-event.com"
        }
    )