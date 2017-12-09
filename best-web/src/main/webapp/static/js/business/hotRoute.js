var showUploadImg = function (index) {
    $("#imgFileEle").data('routeIndex', index);
    $("#imgFileEle").trigger('click');
}
var imgChange = function (event) {
    var formData = new FormData($('#imgFormEle').get(0));
    $.ajax({
        url: '/hotRoute/uploadImage',
        type: 'POST',
        data: formData,
        cache: false,
        dataType: 'json',
        processData: false,
        contentType: false,
        success: function (data, textStatus, jqXHR) {
            if (data.success === true) {
                var $images = $("#images_" + $("#imgFileEle").data('routeIndex'));
                $images.attr('src', data.data);
            } else {
                alert('upload picture fail');
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('upload picture fail');
        },
        complete: function () {
            $("#imgFileEle").val('')
        }
    });
}

var stationHtml = template("stationSelectTemplate", {"cities": cities});
var $stationTbody = $("#stationTbody")
for (var index = 0; index < 8; index++) {
    var routeTrHtml = template("stationTrTemplate", {"stationHtml": stationHtml, "index": index});
    $stationTbody.append(routeTrHtml)
}

var save = function (index) {
    var imgUrl = $.trim($("#images_" + index).attr('src'));
    var startStationCode = $("#startStation_" + index).val();
    var toStationCode = $("#toStation_" + index).val();
    var lowestPrice = $.trim($("#lowestPrice_" + index).val());

    if (!startStationCode) {
        alert("from station can't be empty");
        return;
    }

    if (!toStationCode) {
        alert("from station can't be empty");
        return;
    }

    if (!imgUrl) {
        alert("picture can't be empty");
        return;
    }
    if (!lowestPrice) {
        alert("lowest price can't be empty");
        return;
    }

    $.post('/hotRoute/update', {
        'fromStationCode': startStationCode,
        'toStationCode': toStationCode,
        'lowestPrice': lowestPrice,
        'picUrl': imgUrl,
        'seq': index
    }, function (ret) {
        if (ret.success === true) {
            alert('save success')
            window.location.reload();
        } else {
            alert('save fail')
            window.location.reload();
        }
    }, 'json').fail(function () {
        alert('save fail')
        window.location.reload();
    })

}

var getLowestPrice = function (index) {
    var startStationCode = $("#startStation_" + index).val();
    var toStationCode = $("#toStation_" + index).val();

    if (!startStationCode) {
        alert("from station can't be empty");
        return;
    }

    if (!toStationCode) {
        alert("from station can't be empty");
        return;
    }

    $.post('/hotRoute/getLowestPrice', {
        'fromStationCode': startStationCode,
        'toStationCode': toStationCode
    }, function (ret) {
        if (ret.success === true) {
            $("#lowestPrice_" + index).val(ret.data)
        } else {
            alert('fail,please retry')
        }
    }, 'json').fail(function () {
        alert('fail,please retry')
    })


}

//init
$.each(allHotRoutes, function (i, hotRoute) {
    var seq = hotRoute.seq;
    $("#images_" + seq).attr('src', hotRoute.picUrl)
    $("#startStation_" + seq).val(hotRoute.fromStationCode);
    $("#toStation_" + seq).val(hotRoute.toStationCode);
    $("#lowestPrice_" + seq).val(hotRoute.lowestPrice)
})


