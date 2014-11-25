/**
 * Created by witem on 29.10.14.
 */
$(document).ready(function(){
    clock();
});

function clock() {
    var hoursContainer = $("#dateTime .hours");
    var minutesContainer = $("#dateTime .minutes");
    var secondsContainer = $("#dateTime .seconds");
    var yearContainer = $("#dateTime .year");
    var monthContainer = $("#dateTime .month");
    var dayContainer = $("#dateTime .day");

    // init
    hoursContainer.html((new Date().getHours()<10?'0':'') + new Date().getHours());
    minutesContainer.html((new Date().getMinutes()<10?'0':'') + new Date().getMinutes());
    secondsContainer.html(new Date().getSeconds());
    yearContainer.html( + new Date().getYear() + 1900);
    monthContainer.html( (new Date().getMonth()<9?'0':'') + (+new Date().getMonth() + 1) );
    dayContainer.html( (new Date().getDay()<9?'0':'') + (+new Date().getDay() + 1) );

    setInterval( function() {
        var seconds = new Date().getSeconds();
        var minutes = new Date().getMinutes();

        secondsContainer.html( seconds<10?'0'+seconds:seconds );
        if ( minutes != minutesContainer.html() )
            changeMinutes(minutes);

    }, 1000 );

    function changeMinutes(minutes) {
        minutesContainer.html( minutes<10?'0'+minutes:minutes );

        var hours = new Date().getHours();
        if ( hours != hoursContainer.html() )
            changeHours(hours);
    }

    function changeHours(hours) {
        hoursContainer.html( hours<10?'0'+hours:hours );

        var day = +new Date().getDay() + 1;
        if ( day != dayContainer.html() )
            changeDay(day);
    }

    function changeDay(day) {
        dayContainer.html( day<10?'0'+day:day );

        var month = +new Date().getMonth() + 1;
        if ( month != monthContainer.html() )
            changeMonth(month);
    }

    function changeMonth(month) {
        monthContainer.html( month<10?'0'+month:month );

        var year = new Date().getYear();
        if ( year != yearContainer.html() )
            yearContainer.html(+year + 1900);
    }
}
window.spinerChange = function (windgeId, increment) {
    val = parseInt($("#spiner-"+windgeId).html())
    if (increment)
        $("#spiner-"+windgeId).html(++val)
    else
        $("#spiner-"+windgeId).html(--val)
};