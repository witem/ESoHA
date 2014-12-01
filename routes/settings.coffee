express   = require('express')
menu      = require('../lib/menu')
settings   = require('../lib/settings')

router    = express.Router()

# GET home page.
router.get '/', (req, res)->
  indexObj = { title: 'ESoHA - settings'}
  menu.render().then (menu)->
    indexObj.menuArray = menu
    return "home"
  .then(settings.render).then (settings)->
    indexObj.settingsArray = settings
  .done ()->
    res.render('settings', indexObj)

module.exports = router