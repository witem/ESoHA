$ ()->
  clock()

clock = ()->
  hoursContainer    = $("#dateTime .hours")
  minutesContainer  = $("#dateTime .minutes")
  secondsContainer  = $("#dateTime .seconds")
  yearContainer     = $("#dateTime .year")
  monthContainer    = $("#dateTime .month")
  dayContainer      = $("#dateTime .day")

# init
  hoursContainer.html (if new Date().getHours()<10 then '0' else '') + new Date().getHours()
  minutesContainer.html (if new Date().getMinutes()<10 then '0' else '') + new Date().getMinutes()
  secondsContainer.html new Date().getSeconds()
  yearContainer.html + new Date().getYear() + 1900
  monthContainer.html (if new Date().getMonth()<9 then '0' else '') + (+new Date().getMonth() + 1)
  dayContainer.html (if new Date().getDay()<9 then '0' else '') + (+new Date().getDay() + 1)

  setInterval ()->
    seconds = new Date().getSeconds()
    minutes = new Date().getMinutes()

    secondsContainer.html if seconds<10 then '0'+seconds else seconds
    if minutes != minutesContainer.html()
      changeMinutes minutes
  , 1000

changeMinutes = (minutes)->
  minutesContainer.html if minutes<10 then '0'+minutes else minutes

  hours = new Date().getHours()
  if hours != +hoursContainer.html()
    changeHours hours

changeHours = (hours)->
  hoursContainer.html if hours<10 then '0'+hours else hours

  day = +new Date().getDay() + 1
  if day != dayContainer.html()
    changeDay day

changeDay = (day)->
  dayContainer.html if day<10 then '0'+day else day

  month = +new Date().getMonth() + 1
  if month != monthContainer.html()
    changeMonth month

changeMonth = (month)->
  monthContainer.html if month<10 then '0'+month else month

  year = new Date().getYear()
  if year != yearContainer.html()
    yearContainer.html +year + 1900

window.spinerChange = (windgeId, increment)->
  val = parseInt $("#spiner-"+windgeId).html()
  if (increment)
    $("#spiner-"+windgeId).html ++val
  else
    $("#spiner-"+windgeId).html --val
