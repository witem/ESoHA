Q  = require('q');
fs = require('fs');


getLogObject = ()->
  deferred  = Q.defer()
  fileUrl   = './data/log.json'

  fs.readFile fileUrl, "utf-8", (err, data)->
    if err
      deferred.reject ":-[ log.coffee -> #{err}"
    else
      deferred.resolve JSON.parse(data)

  return deferred.promise

logToHTML = (log)->
  html    = []

  for item in log
    date = new Date (+item.timestamp)
    html.push "<li class='log-item #{item.type}'>
      <span class='date'>#{date.getDay()}.#{date.getMonth()+1}.#{date.getFullYear()}
      #{date.getHours()}:#{date.getMinutes()}:#{date.getSeconds()}</span>
      #{item.message}
      </li>"

  return html

renderL =  ()->
  deferred = Q.defer()

  getLogObject()
  .then logToHTML
  .then(null, console.error).done (data)->
    deferred.resolve(data)

  return deferred.promise

module.exports.render = renderL