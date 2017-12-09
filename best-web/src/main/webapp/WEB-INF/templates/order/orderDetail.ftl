<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>order detail</title>
    <link rel="stylesheet" type="text/css" href="/static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="/static/css/index.css">
    <script type="text/javascript" src="/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/js/template.js"></script>
    <script type="text/javascript" src="/static/js/template.helper.js"></script>
    <script language="javascript" type="text/javascript" src="/static/My97DatePicker/WdatePicker.js"></script>
    <style>
        .inputLabel {
            margin-right: 15px;
        }

        table.border, .border tr, .border td, .border th {
            border: 1px solid;
            border-collapse: collapse;
        }

        td {
            text-align: left;
        }
    </style>
    <script>
        var failCode =${failCode}
        var data =${orderDetail}
    </script>
</head>
<body>
<!-- BaseOrderInfo paymentInfo ContactInfo -->
<div>
    <div style="float:left">
        <div class="easyui-panel" title="Base Order Info" style="width:500px;height:250px;padding:10px;">
            <div style="float: left" id="baseOrderInfoDivLeft">
                <!--baseOrderInfoDivLeft-->
            </div>
            <div style="float: left;margin-left: 15px" id="baseOrderInfoDivRight">
                <!-- baseOrderInfoDivRight -->
            </div>

        </div>
    </div>
    <div style="float:left;margin-left: 15px">
        <div>
            <div id="paymentInfoDiv" class="easyui-panel" title="payment info"
                 style="width:500px;height:200px;padding:10px;">
                <!-- paymentInfo -->
            </div>
        </div>
        <div>
            <div id="contactTemplateDiv" class="easyui-panel" title="concat info"
                 style="width:500px;height:200px;padding:10px;">
                <!-- concat info-->
            </div>
        </div>
    </div>
</div>
<div style="clear:both"></div>
<!-- passengers Info -->
<div>
    <div class="easyui-panel" title="Passengers info" style="width:500px;height:200px;padding:10px;">
        <table class="border" width="100%">
            <tr>
                <th>No</th>
                <th>passenger type</th>
                <th>title</th>
                <th>name</th>
                <th>ID type</th>
                <th>ID number</th>
            </tr>
            <tbody id="passengersInfoTbody">

            </tbody>
        </table>
    </div>
</div>

<!-- price Info -->
<div>
    <div id="priceInfoDiv" class="easyui-panel" title="Price Info" style="width:500px;height:250px;padding:10px;">

    </div>
</div>

<!-- TrainInfo -->
<div>
    <div  class="easyui-panel" title="Train Info" style="width:700px;height:200px;padding:10px;">
        <table class="border" style="width: 100%">
            <tr>
                <th>Route</th>
                <th>train name</th>
                <th>departure station</th>
                <th>departure time</th>
                <th>arrival station</th>
                <th>arrival time</th>
                <th>duration</th>
                <th>seat class</th>
                <th>seat number</th>
            </tr>
            <tbody id="trainInfoTbody">

            </tbody>
        </table>
    </div>
</div>

<script id="baseOrderInfoTemplateLeft" type="text/html">
    <table>
        <tr>
            <th>erpOrderId</th>
            <td>{{erpOrderId}}</td>
            <th>Order Type</th>
            <td>
                {{if trips==1}}
                one way
                {{else if trips==2}}
                return
                {{else}}
                unknow
                {{/if}}
            </td>
        </tr>
        <tr>
            <th>venderOrderId</th>
            <td>{{gdsBookCode}}</td>
            <th>expiredTime</th>
            <td>{{lastPayTimeStr}}</td>
        </tr>
        <tr>
            <th>user</th>
            <td>{{userPin}}</td>
            <th>uuid</th>
            <td>uuid-todo...</td>
        </tr>
        <tr>
            <th>orderSource</th>
            <td>
                {{if sourceCode==1}}
                PC browser
                {{else if sourceCode==2}}
                IOS app
                {{else if sourceCode==3}}
                android app
                {{else if sourceCode==4}}
                mobile browser
                {{else}}
                unknow
                {{/if}}
            </td>
            <th>userIP</th>
            <td>{{userIp}}</td>
        </tr>
        <tr>
            <th>orderStatus</th>
            <td>todo...</td>
            <th>User time remaining</th>
            <td>todo..</td>
        </tr>
        <tr>
            <th>Order price(IDR)</th>
            <td>{{totalPrice}}</td>
            <th>Real time remaining</th>
            <td>todo..</td>
        </tr>
        <tr>
            <th>created</th>
            <td>{{createdStr}}</td>
        </tr>
    </table>
</script>
<script id="paymentInfoTemplate" type="text/html">
    <table>
        <tr>
            <th>order price(IDR)</th>
            <td>{{totalPrice}}</td>
        </tr>
        <tr>
            <th>pay price(IDR)</th>
            <td>{{finalPayment}}</td>
        </tr>
        <tr>
            <th>pay status</th>
            <td>todo...</td>
        </tr>
        <tr>
            <th>pay time</th>
            <td>{{payTimeStr}}</td>
        </tr>
        <tr>
            <th>Coupon</th>
            <td>{{couponTotalAmount}}</td>
        </tr>
    </table>
</script>
<script id="contactTemplate" type="text/html">
    <table>
        <tr>
            <th>title</th>
            <td>todo...</td>
        </tr>
        <tr>
            <th>name</th>
            <td>{{contactName}}</td>
        </tr>
        <tr>
            <th>email</th>
            <td>{{contactEmail}}</td>
        </tr>
        <tr>
            <th>phone</th>
            <td>{{contactPhone}}</td>
        </tr>
    </table>
</script>
<script id="passengersInfoTemplate" type="text/html">
    {{each orderPassengers as p}}
    <tr>
        <td>todo..</td>
        <td>{{p.passengerType}}</td>
        <td>todo..</td>
        <td>{{p.passengerName}}</td>
        <td>
            {{if p.identityTypeCode==1}}
            idCard
            {{else}}
            ({{p.identityTypeCode}})unknown
            {{/if}}
        </td>
        <td>{{p.identityInfo}}</td>
    </tr>
    {{/each}}
</script>

<script id="priceInfoTemplate" type="text/html">
    <table>
        <tr>
            <th colspan="2">Kereta Pergi</th>
        </tr>
        <tr>
            <td>Argo Parahyangan Premium (Dewasa) x1</td>
            <td>todo..</td>
        </tr>
        <tr>
            <td>Argo Parahyangan Premium (Bayi) x1</td>
            <td>todo..</td>
        </tr>
        <tr>
            <th colspan="2">Kereta Pulang</th>
        </tr>
        <tr>
            <td>Argo Parahyangan (Dewasa) x1</td>
            <td>todo..</td>
        </tr>
        <tr>
            <td>Argo Parahyangan (Bayi) x1</td>
            <td>todo..</td>
        </tr>
    </table>
    <table>
        <tr>
            <th>Total Barang</th>
            <td>todo..</td>
        </tr>
        <tr>
            <th>Kupon/kode kupon</th>
            <td>tod..</td>
        </tr>
        <tr>
            <th>Jumlah semua</th>
            <td>todo..</td>
        </tr>
    </table>
</script>
<script id="trainInfoTemplate" type="text/html">
    {{each orderTrips as t}}
    <tr>
        <td>todo...</td>
        <td>{{t.trainName}}</td>
        <td>todo..</td>
        <td>{{t.departDateStr}}</td>
        <td>todo...</td>
        <td>{{t.arriveDateStr}}</td>
        <td>todo...</td>
        <td>
            {{if t.trainTypeCode==1}}
            economy
            {{else if t.trainTypeCode==2}}
            business
            {{else if t.trainTypeCode==3}}
            executive
            {{else}}
            unknow
            {{/if}}
        </td>
        <td>todo...</td>
    </tr>
    {{/each}}
</script>

<script type="text/javascript" src="/static/js/business/orderDetail.js"></script>
</body>
</html>