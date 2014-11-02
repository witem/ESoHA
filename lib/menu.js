var fs = require('fs');

var renderMenu =  function() {
    var menus = getMenuElements();

    console.log('menus - ' + menus);
    menus = {'one': 'room', 'two': 'settings', 'three': 'logout'};
    return menus;
};

function getMenuElements() {
    var fileUrl = './data/menu.json';
    var obj;

    fs.readFile(fileUrl, 'utf8', function (err, data) {
        if (err) throw err;

        obj = JSON.parse(data);

        console.log('1---1', obj)
        return obj;
    });
};

module.exports.renderMenu = renderMenu;