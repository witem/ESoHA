var Q = require('q');
var fs = require('fs');

function parseWidget( parsed ) {
    var widgets = [];
    for (var chunk in parsed) {
        widgets.push({
            'id': parsed[chunk].id,
            'name': parsed[chunk].name,
            'type': parsed[chunk].type,
            'page': parsed[chunk].page,
            'featured': parsed[chunk].featured
        });
    };
    return widgets;
};
function widgetToHTML ( widgetsData ) {
    var html = [];
    var temp = '';
    var widget = {};

    for (var i = 0; i < widgetsData.length; i++) {
        widget = widgetsData[i];
        switch (widget.type) {
            case 'swicher':
                temp = '<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3"><p>' + widget.name + '</p>';
                temp += '<div class="btn-group" data-toggle="buttons">';
                temp += '<label class="btn btn-default active"><input type="radio" name="on" id="option1" autocomplete="off" checked>on</label>';
                temp += '<label class="btn btn-default"><input type="radio" name="off" id="option2" autocomplete="off">off</label>';
                temp += '</div></div>';
                html.push(temp);
                break;
            case 'slider':
                temp = '<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3"><p>' + widget.name + '</p>';
                temp += '<div><div id="slider-' + widget.id + '"></div>';
                temp += '</div></div>';
                temp += '<script>$( "#slider-' + widget.id + '" ).slider();</script>';
                html.push(temp);
                break;
            case 'info':
                temp = '<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3"><p>' + widget.name + '</p>';
                temp += '<div><var>value 13` C</var>';
                temp += '</div></div>';
                html.push(temp);
                break;
            case 'spiner':
                temp = '<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3"><p>' + widget.name + '</p>';
                temp += '<div><button class="btn btn-default" onclick="spinerChange('+widget.id+',true)">+</button>';
                temp += ' <span id="spiner-' + widget.id + '"> 5 </span> ';
                temp += '<button class="btn btn-default" onclick="spinerChange('+widget.id+',false)">-</button>';
                temp += '</div></div>';
                html.push(temp);
                break;
            default:
                break;
        }
    };

    return html;
}
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
    if ( feature == undefined )
     feature = false
    var deferred = Q.defer();
    getWidgetObject()
        .then(parseWidget)
        .then(widgetToHTML)
        .then(null, console.error).done(function(data){
            deferred.resolve(data)
        });

    return deferred.promise;
};
module.exports.renderWidget = renderW;