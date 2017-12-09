<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>order manager</title>
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
            text-align: center;
        }
        .overHight {
            background-color: #B4D5FE;
        }
    </style>
</head>
<body>
<div>
    <div>
        <span>
            orderId:<input type="" id="orderId"/>
        </span>
        <span>
            erpOrderId:<input type="" id="erpOrderId"/>
        </span>
        <span>
            Booking ID:<input type="" id="gdsBookCode"/>
        </span>
        <span>
            user:<input type="" id="userPin"/>
        </span>
        <span>
            orderSource:
            <select id="source">
                <option value="">all</option>
                <option value="1">PC browser</option>
                <option value="2">IOS app</option>
                <option value="3">android app</option>
                <option value="4">mobile browser</option>
            </select>
        </span>
        <span>
            Order Validity:
            <select id="orderValid">
                <option value="">all</option>
                <option value="1">valid</option>
                <option value="0">invalid</option>
            </select>
        </span>
    </div>
    <br/>
    <div>
        <span>
            Order Type:
            <select id="orderType">
                <option value="">all</option>
                <option value="1">one way</option>
                <option value="2">return</option>
            </select>
        </span>
        <span>
            Order Status:
            <select>
                <option value="">todo</option>
            </select>
        </span>
        <span>
            Coupon:<input type="checkbox" id="coupon"/>
        </span>
        <span>
            Phone:<input type="" id="contactPhone"/>
        </span>
        <span>
            created From:<input onClick="WdatePicker({lang:'en'})" readonly id="createdFrom"/>
            to:<input onClick="WdatePicker({lang:'en'})" readonly id="createdTo"/>
        </span>
    </div>
    <br/>
    <div>
        <input type="button" value="submit" onclick="query()"/>
        <input type="button" value="reset" onclick="reset()"/>
        <input type="button" value="export" onclick="exportExcel()"/>
    </div>
</div>
<div id="retDiv" style="margin-top: 20px">
    <table class="border" style="width: 100%">
        <tr>
            <th>orderId</th>
            <th>erpOrderId</th>
            <th>Booking ID</th>
            <th>Order Type</th>
            <th>User</th>
            <th>Order Source</th>
            <th>Order Status</th>
            <th>Quantity</th>
            <th>Order Time</th>
            <th>Pay Time</th>
            <th>Vender</th>
            <th>Order price(IDR)</th>
            <th>Pay price(IDR)</th>
            <th>Coupon price(IDR)</th>
            <th>Operation</th>
        </tr>
        <tbody id="tbody">

        </tbody>
    </table>
    <div>
        <div id="pageList"></div>
    </div>
</div>

<script id="rowTemplate" type="text/html">
    {{each list}}
    <tr>
        <td>{{$value.orderId}}</td>
        <td>{{$value.erpOrderId}}</td>
        <td>{{$value.gdsBookCode}}</td>
        <td>
            {{if $value.trips==1}}
            one way
            {{else if $value.trips==2}}
            return
            {{else}}
            unknow
            {{/if}}
        </td>
        <td>{{$value.userPin}}</td>
        <td>
            {{if $value.sourceCode==1}}
            PC browser
            {{else if $value.sourceCode==2}}
            IOS app
            {{else if $value.sourceCode==3}}
            android app
            {{else if $value.sourceCode==4}}
            mobile browser
            {{else}}
            unknow
            {{/if}}
        </td>
        <td>
            orderStatus-todo
        </td>
        <td>{{$value.passengers}}</td>
        <td>{{$value.createdStr}}</td>
        <td>{{$value.payTimeStr}}</td>
        <td>vender-todo</td>
        <td>{{$value.totalPrice}}</td>
        <td>{{$value.finalPayment}}</td>
        <td>{{$value.couponTotalAmount}}</td>
        <td><input type="button" value="viewDetail" onclick="goDetail({{$value.orderId}})"/></td>
    </tr>
    {{/each}}
</script>
<script>

    var goDetail = function (id) {
        if (window.top && window.top.openTab) {
            window.top.openTab("/orderManager/orderDetail?orderId=" + id, 'orderDetail')
        } else {
            window.location.href = "/orderManager/orderDetail?orderId=" + id
        }
    }

    var loadPageBar = function (ps, pageNumber, totalCount) {
        $('#pageList').pagination({
            total: totalCount,
            pageSize: ps,
            pageNumber: pageNumber,
            showPageList: false,
            onSelectPage: queryInner,
        })
        $("#retDiv tr").hover(
                function () {
                    $(this).addClass('overHight')
                }, function () {
                    $(this).removeClass('overHight')
                }
        )
    }

    var query = function () {
        queryInner(1)
    }

    var trim = function (val) {
        return $.trim(val);
    }

    var setIfNotEmpty = function (obj, attr, val) {
        var trimVal = $.trim(val);
        if (trimVal) {
            obj[attr] = trimVal
        }
    }


    var queryInner = function (pageNumber) {
        var params = {}
        setIfNotEmpty(params, 'orderId', $('#orderId').val())
        setIfNotEmpty(params, 'erpOrderId', $('#erpOrderId').val())
        setIfNotEmpty(params, 'gdsBookCode', $('#gdsBookCode').val())
        setIfNotEmpty(params, 'userPin', $('#userPin').val())
        setIfNotEmpty(params, 'source', $('#source').val())
        setIfNotEmpty(params, 'orderValid', $('#orderValid').val())
        setIfNotEmpty(params, 'orderType', $('#orderType').val())
        setIfNotEmpty(params, 'coupon', $('#coupon').is(":checked") ? 1 : '')
        setIfNotEmpty(params, 'contactPhone', $('#contactPhone').val())
        setIfNotEmpty(params, 'createdFrom', $('#createdFrom').val())
        setIfNotEmpty(params, 'createdTo', $('#createdTo').val())
        params.pageNum = pageNumber

        $.post('/orderManager/listData', params, function (data) {
            var html = template('rowTemplate', data);
            $("#tbody").html(html);
            loadPageBar(data.pageSize, data.pageNum, data.total)
        }, 'json').fail(function (data) {
            if (data.status == 401 && data.statusText == 'Unauthorized') {
                alert('login timeout,try login again');
            } else {
                alert("request fail,try again");
            }
        })
    }

    var reset = function () {
        $('#erpOrderId').val('')
        $('#gdsBookCode').val('')
        $('#userPin').val('')
        $('#source').val('')
        $('#orderValid').val('')
        $('#orderType').val('')
        $('#contactPhone').val('')
        $('#createdFrom').val('')
        $('#createdTo').val('')
        $('#coupon').attr('checked', false)
        $('#createdTo').val('')
    }

    var exportExcel = function () {
        var params = {}
        setIfNotEmpty(params, 'orderId', $('#orderId').val())
        setIfNotEmpty(params, 'erpOrderId', $('#erpOrderId').val())
        setIfNotEmpty(params, 'gdsBookCode', $('#gdsBookCode').val())
        setIfNotEmpty(params, 'userPin', $('#userPin').val())
        setIfNotEmpty(params, 'source', $('#source').val())
        setIfNotEmpty(params, 'orderValid', $('#orderValid').val())
        setIfNotEmpty(params, 'orderType', $('#orderType').val())
        setIfNotEmpty(params, 'coupon', $('#coupon').is(":checked") ? 1 : '')
        setIfNotEmpty(params, 'contactPhone', $('#contactPhone').val())
        setIfNotEmpty(params, 'createdFrom', $('#createdFrom').val())
        setIfNotEmpty(params, 'createdTo', $('#createdTo').val())

        window.location.href = "/orderManager/export?" + $.param(params);
    }
</script>
</body>
</html>