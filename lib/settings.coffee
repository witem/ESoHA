Q  = require('q');
fs = require('fs');


getSettingsObject = ()->
  deferred  = Q.defer()
  fileUrl   = './data/settings.json'

  fs.readFile fileUrl, "utf-8", (err, data)->
    if err
      deferred.reject ":-[ settings.coffee -> #{err}"
    else
      deferred.resolve JSON.parse(data)

  return deferred.promise

parseSettings = ( parsed )->
  settings = [];
  for chunk of parsed
    settings.push
      id      : parsed[chunk].id
      name    : parsed[chunk].name
      type    : parsed[chunk].type

  return settings

settingsToHTML = (settingsData)->
  html    = []

  for setting in settingsData
    switch setting.type
      when 'swicher'
        html.push "<div class='col-xs-6 col-sm-4 col-md-3 col-lg-3'><p>#{setting.name}</p>
          <div class='btn-group' data-toggle='buttons'>
          <label class='btn btn-default active'><input type='radio' name='on' id='option1' autocomplete='off' checked>on</label>
          <label class='btn btn-default'><input type='radio' name='off' id='option2' autocomplete='off'>off</label>
          </div></div>"
      when 'slider'
        html.push "<div class='col-xs-6 col-sm-4 col-md-3 col-lg-3'><p>#{setting.name}</p>
          <div><div id='slider-#{setting.id}'></div></div></div>
          <script>$( '#slider-#{setting.id}' ).slider();</script>"
      when 'info'
        html.push "<div class='col-xs-6 col-sm-4 col-md-3 col-lg-3'><p>#{setting.name}</p>
          <div><var>value 13` C</var>
          </div></div>"
      when 'spiner'
        html.push "<div class='col-xs-6 col-sm-4 col-md-3 col-lg-3'><p>#{setting.name}</p>
          <div><button class='btn btn-default' onclick='spinerChange(#{setting.id},true);'>+</button>
          <span id='spiner-#{setting.id}'> 5 </span>
          <button class='btn btn-default' onclick='spinerChange(#{setting.id},false)'>-</button>
          </div></div>"
      else
        break

  return html

renderS =  ()->
  deferred = Q.defer()

  getSettingsObject()
  .then parseSettings
  .then settingsToHTML
  .then(null, console.error).done (data)->
    deferred.resolve(data)

  return deferred.promise

module.exports.render = renderS