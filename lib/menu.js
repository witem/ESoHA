var fs = require('fs');
var debug = require('debug')('ESoHA');

var renderMenu =  function() {
    var menus = [];
    var data = getMenuElements();

    for (var val in data) {
        menus.push({
            'name': data[val].name,
            'href': data[val].class + '-' + data[val].id
        });
    }

    return menus;
};

function getMenuElements() {
    var fileUrl = './data/menu.json';
    var obj = JSON.parse(fs.readFileSync(fileUrl, 'utf8'));

    //fs.readFile(fileUrl, 'utf8', function (err, data) {
    //    if (err) throw err;
    //
    //    obj = JSON.parse(data);
    //});

    return obj;
}

module.exports.renderMenu = renderMenu;