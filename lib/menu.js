var fs = require('fs');

var renderMenu = function(callback) {

    return getMenuObject(function (parsed) {
        var menus = [];

        for (var chunk in parsed) {
            menus.push({
                'name': parsed[chunk].name,
                'href': parsed[chunk].class + '-' + parsed[chunk].id
            });
        };

        return callback(menus);
    });

};

function getMenuObject (cb) {
    var fileUrl = './data/menu.json';

    fs.readFile(fileUrl, 'utf8', function (err, data) {
        if (err) throw err;
        var parsed = JSON.parse(data);
        return !!cb ? cb(parsed) : parsed;
    });
}

module.exports.renderMenu = renderMenu;