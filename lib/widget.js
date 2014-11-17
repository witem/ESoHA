var Q = require('q');
var fs = require('fs');

var renderWidget = function( parsed ) {
    var widgets = [];
    console.log(feature);
    for (var chunk in parsed) {
        widgets.push({
            'id': parsed[chunk].id,
            'name': parsed[chunk].name,
            'type': parsed[chunk].type
        });
    };

    return widgets;
};

function getWidgetObject() {
    var deferred = Q.defer();
    var fileUrl = './data/widget.json';

    fs.readFile(fileUrl, "utf-8", function (err, data) {
        if (err) {
            deferred.reject( ":-[ widget.js-> " + err)
        } else {
            deferred.resolve(JSON.parse(data))
        }
    });
    return deferred.promise;
}

var renderW =  function( feature ) {
    var deferred = Q.defer();
    getWidgetObject()
        .then(renderWidget)
        .then(null, console.error).done(function(data){
            deferred.resolve(data)
        });

    return deferred.promise;
};
module.exports.renderWidget = renderW;