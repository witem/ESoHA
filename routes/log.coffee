express   = require 'express'
menu      = require '../lib/menu'
log       = require '../lib/log'

router    = express.Router()

# GET home page.
router.get '/', (req, res)->
  indexObj = { title: 'ESoHA - log'}
  menu.render().then (menu)->
    indexObj.menuArray = menu
    return "home"
  .then(log.render).then (log)->
    indexObj.logArray = log
  .done ()->
    res.render('log', indexObj)

module.exports = router