Q  = require('q');
fs = require('fs');

parseWidget = (parsed)->
  widgets = [];
  for chunk of parsed
    widgets.push
        id      : parsed[chunk].id
        name    : parsed[chunk].name
        type    : parsed[chunk].type
        page    : parsed[chunk].page
        featured: parsed[chunk].featured

  return widgets

widgetToHTML = (widgetsData)->
  html    = []

  for widget in widgetsData
    switch widget.type
      when 'swicher'
        html.push "<div class='col-xs-6 col-sm-4 col-md-3 col-lg-3'><p>#{widget.name}</p>
          <div class='btn-group' data-toggle='buttons'>
          <label class='btn btn-default active'><input type='radio' name='on' id='option1' autocomplete='off' checked>on</label>
          <label class='btn btn-default'><input type='radio' name='off' id='option2' autocomplete='off'>off</label>
          </div></div>"
      when 'slider'
        html.push "<div class='col-xs-6 col-sm-4 col-md-3 col-lg-3'><p>#{widget.name}</p>
          <div><div id='slider-#{widget.id}'></div></div></div>
          <script>$( '#slider-#{widget.id}' ).slider();</script>"
      when 'info'
        html.push "<div class='col-xs-6 col-sm-4 col-md-3 col-lg-3'><p>#{widget.name}</p>
          <div><var>value 13` C</var>
          </div></div>"
      when 'spiner'
        html.push "<div class='col-xs-6 col-sm-4 col-md-3 col-lg-3'><p>#{widget.name}</p>
          <div><button class='btn btn-default' onclick='spinerChange(#{widget.id},true);'>+</button>
          <span id='spiner-#{widget.id}'> 5 </span>
          <button class='btn btn-default' onclick='spinerChange(#{widget.id},false)'>-</button>
          </div></div>"
      else
        break

  return html

getWidgetObject = ()->
  deferred  = Q.defer()
  fileUrl   = './data/widget.json'

  fs.readFile fileUrl, "utf-8", (err, data)->
    if err
      deferred.reject ":-[ widget.coffee -> #{err}"
    else
      deferred.resolve JSON.parse(data)

  return deferred.promise

renderW =  (feature)->
  feature ?= false
  deferred = Q.defer()

  getWidgetObject()
  .then parseWidget
  .then widgetToHTML
  .then(null, console.error).done (data)->
    deferred.resolve(data)

  return deferred.promise

module.exports.renderWidget = renderW