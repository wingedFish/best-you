var renderOrderDetailPage = function () {

    var baseOrderInfoLeftHtml = template('baseOrderInfoTemplateLeft', data);
    $("#baseOrderInfoDivLeft").html(baseOrderInfoLeftHtml);

    var paymentInfoHtml = template('paymentInfoTemplate', data);
    $("#paymentInfoDiv").html(paymentInfoHtml);

    var contactTemplateDivHtml=template('contactTemplate',data);
    $("#contactTemplateDiv").html(contactTemplateDivHtml);

    var passengersInfoHtml=template('passengersInfoTemplate',data)
    $("#passengersInfoTbody").html(passengersInfoHtml);

    var priceInfoHtml=template('priceInfoTemplate',data)
    $("#priceInfoDiv").html(priceInfoHtml)

    var trainInfoHtml=template('trainInfoTemplate',data)
    $("#trainInfoTbody").html(trainInfoHtml)
}
if (failCode == 1) {
    alert('load fail,please try');
}
if (failCode == 2) {
    alert("orderDetail does not exist")
}
//没有错误发生
if (failCode == 0) {
    renderOrderDetailPage();
}

