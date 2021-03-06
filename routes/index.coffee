express   = require('express')
menu      = require('../lib/menu')
widget    = require('../lib/widget')

router    = express.Router()

# GET home page.
router.get '/', (req, res)->
  indexObj = { title: 'ESoHA - home'}
  menu.render().then (menu)->
    indexObj.menuArray = menu
    return "home"
  .then(widget.render).then (widget)->
    indexObj.widgetArray = widget
  .done ()->
    res.render('index', indexObj)

module.exports = router
