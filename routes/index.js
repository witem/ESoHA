var express = require('express');
var router = express.Router();
var menu = require('../lib/menu');

/* GET home page. */
router.get('/', function(req, res) {

  menu.renderMenu(function(menus){

    res.render('index', {
      title: 'ESoHA',
      menuArray: menus
    });

  })

});

module.exports = router;
