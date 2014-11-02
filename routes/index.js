var express = require('express');
var router = express.Router();
var menu = require('../lib/menu');

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', {
    title: 'ESoHA',
    menuArray: menu.renderMenu()
  });
});

module.exports = router;
