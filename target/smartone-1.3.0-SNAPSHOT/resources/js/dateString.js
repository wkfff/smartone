function dateString(time) {
    var date = new Date(time);
    var myYear = date.getYear();
    var year = (myYear > 200) ? myYear : 1900 + myYear; // 多浏览器支持
    return year + "-" + (date.getMonth() + 1) + "-" + date.getDate();
}
function timeString(time) {
    var date = new Date(time);
    return date.getYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes();
}

function string2Date(dateString) {
    var date = eval('new Date(' + dateString.replace(/\d+(?=-[^-]+$)/, function(a) {
        return parseInt(a, 10) - 1;
    }).match(/\d+/g) + ')');
    return date;
}

function getDateBefore(date, days) {
    return new Date(date.getTime() - days * 24 * 3600 * 1000);
}