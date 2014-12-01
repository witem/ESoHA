$(function() {
  var changeDay, changeHours, changeMinutes, changeMonth, clock, dayContainer, hoursContainer, minutesContainer, monthContainer, secondsContainer, yearContainer;
  hoursContainer = $("#dateTime .hours");
  minutesContainer = $("#dateTime .minutes");
  secondsContainer = $("#dateTime .seconds");
  yearContainer = $("#dateTime .year");
  monthContainer = $("#dateTime .month");
  dayContainer = $("#dateTime .day");
  clock = function() {
    hoursContainer.html((new Date().getHours() < 10 ? '0' : '') + new Date().getHours());
    minutesContainer.html((new Date().getMinutes() < 10 ? '0' : '') + new Date().getMinutes());
    secondsContainer.html(new Date().getSeconds());
    yearContainer.html(+new Date().getYear() + 1900);
    monthContainer.html((new Date().getMonth() < 9 ? '0' : '') + (+new Date().getMonth() + 1));
    dayContainer.html((new Date().getDay() < 9 ? '0' : '') + (+new Date().getDay() + 1));
    return setInterval(function() {
      var minutes, seconds;
      seconds = new Date().getSeconds();
      minutes = new Date().getMinutes();
      secondsContainer.html(seconds < 10 ? '0' + seconds : seconds);
      if (minutes !== minutesContainer.html()) {
        return changeMinutes(minutes);
      }
    }, 1000);
  };
  changeMinutes = function(minutes) {
    var hours;
    minutesContainer.html(minutes < 10 ? '0' + minutes : minutes);
    hours = new Date().getHours();
    if (hours !== +hoursContainer.html()) {
      return changeHours(hours);
    }
  };
  changeHours = function(hours) {
    var day;
    hoursContainer.html(hours < 10 ? '0' + hours : hours);
    day = +new Date().getDay() + 1;
    if (day !== dayContainer.html()) {
      return changeDay(day);
    }
  };
  changeDay = function(day) {
    var month;
    dayContainer.html(day < 10 ? '0' + day : day);
    month = +new Date().getMonth() + 1;
    if (month !== monthContainer.html()) {
      return changeMonth(month);
    }
  };
  changeMonth = function(month) {
    var year;
    monthContainer.html(month < 10 ? '0' + month : month);
    year = new Date().getYear();
    if (year !== yearContainer.html()) {
      return yearContainer.html(+year + 1900);
    }
  };
  return clock();
});

window.spinerChange = function(windgeId, increment) {
  var val;
  val = parseInt($("#spiner-" + windgeId).html());
  if (increment) {
    return $("#spiner-" + windgeId).html(++val);
  } else {
    return $("#spiner-" + windgeId).html(--val);
  }
};
