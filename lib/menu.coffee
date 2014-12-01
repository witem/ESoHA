Q  = require('q')
fs = require('fs')

renderMenu = (parsed)->
  menus = [];

  for chunk of parsed
    menus.push
      'name': parsed[chunk].name
      'href': parsed[chunk].class + '-' + parsed[chunk].id #TODO readable href

  return menus

getMenuObject = ()->
  deferred = Q.defer();
  fileUrl = './data/menu.json';

  fs.readFile fileUrl, "utf-8", (err, data)->
    if err
      deferred.reject ":-[ menu.coffee-> #{err}"
    else
      deferred.resolve JSON.parse(data)

  return deferred.promise

renderM =  ()->
  deferred = Q.defer()
  getMenuObject()
  .then renderMenu
  .then(null, console.error).done (data)->
    deferred.resolve(data)

  return deferred.promise #TODO menu element "Правила автоматизації"

module.exports.render = renderM;