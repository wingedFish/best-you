;(function (t) {
    var pad2 = function (n) {
        return n < 10 ? '0' + n : n
    }

    template.helper('dateFormat', function (date, format) {
        var d = new Date(date)
        var year = d.getFullYear()
        var month = d.getMonth()+1;
        var day = d.getDate();
        var hour = d.getHours();
        var minutes = d.getMinutes();
        var seconds = d.getSeconds();

        var month2 = pad2(month);
        var day2 = pad2(day);
        var hour2 = pad2(hour);
        var minutes2 = pad2(minutes);
        var seconds2 = pad2(seconds);

        var ret = format.replace('yyyy', year)
            .replace('MM', month2)
            .replace('dd', day2)
            .replace('HH', hour2)
            .replace('mm', minutes2)
            .replace('ss', seconds2)

        ret = ret.replace('yyyy', year)
            .replace('M', month)
            .replace('d', day)
            .replace('H', hour)
            .replace('m', minutes)
            .replace('s', seconds)

        return ret;
    });
})(template)