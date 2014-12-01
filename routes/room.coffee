express   = require 'express'
menu      = require '../lib/menu'
widget    = require '../lib/widget'

router  = express.Router()

# GET users listing.
router.get '/', (req, res, next)->
  pageId = /room-(\d+)/.exec(req.baseUrl)[1]
  throw new Error("Error parse url #{req.baseUrl}") unless pageId?

  indexObj = { title: 'ESoHA - room-'+pageId}

  menu.render().then (menu)->
    indexObj.menuArray = menu
    return 'room-'+pageId
  .then(widget.render).then (widget)->
    indexObj.widgetArray = widget
  .done ()->
    unless indexObj.widgetArray.length
      err = new Error('Not Found room')
      err.status = 404
      next err
    else
      res.render 'index', indexObj

module.exports = router