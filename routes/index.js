var express = require('express');
var router = express.Router();
var menu = require('../lib/menu');
var widget = require('../lib/widget');

/* GET home page. */
router.get('/', function(req, res) {
    var indexObj = { title: 'ESoHA'}
    menu.renderMenu().then(function(menu){
        indexObj.menuArray = menu;
    })
    .then(widget.renderWidget).then(function(widget){
        indexObj.widgetArray = widget;
    })
    .done(function(){
        res.render('index', indexObj);
    })
});
module.exports = router;
