<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>refund manager</title>
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
        <span>orderId:<input type="" id="orderId"/></span>
        <span>
            erpOrderId:<input type="" id="erpOrderId"/>
        </span>
        <span>
            refundId:<input type="" id="refundId"/>
        </span>
        <span>
            userPin:<input type="" id="userPin"/>
        </span>
        <span>
            refundStatus:
            <select id="refundStatus">
                <option value="">all</option>
                <option value="0">init</option>
                <option value="1">call jmi success</option>
                <option value="2">cal jim fail</option>
                <option value="3">refund success</option>
                <option value="4">refund fail</option>
            </select>
        </span>
        <br/>
        <span>
            created From:<input onClick="WdatePicker({lang:'en'})" readonly id="createdFrom"/>
            to:<input onClick="WdatePicker({lang:'en'})" readonly id="createdTo"/>
        </span>
    </div>
    <br/>
    <div>
        <input type="button" value="submit" onclick="query()"/>
        <input type="button" value="reset" onclick="reset()"/>
    </div>
</div>
<div id="retDiv" style="margin-top: 20px">
    <table class="border" style="width: 100%">
        <tr>
            <th>refundId</th>
            <th>orderId</th>
            <th>erpOrderId</th>
            <th>userPin</th>
            <th>refundFee</th>
            <th>refundStatus</th>
            <th>finishTime</th>
            <th>created</th>
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
        <td>{{$value.refundId}}</td>
        <td>{{$value.orderId}}</td>
        <td>{{$value.erpOrderId}}</td>
        <td>{{$value.userPin}}</td>
        <td>{{$value.refundFee}}</td>
        <td>
            {{if $value.refundStatus==0}}
            init
            {{else if $value.refundStatus==1}}
            call jmi success
            {{else if $value.refundStatus==2}}
            cal jim fail
            {{else if $value.refundStatus==3}}
            refund success
            {{else if $value.refundStatus==4}}
            refund fail
            {{else}}
            unknow
            {{/if}}
        </td>
        <td>{{$value.finishTime}}</td>
        <td>{{$value.created}}</td>
    </tr>
    {{/each}}
</script>
<script>

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

    var setIfNotEmpty=function(obj,attr,val){
        var trimVal=$.trim(val);
        if(trimVal){
            obj[attr]=trimVal
        }
    }

    var queryInner = function (pageNumber) {
        var params = {}
        setIfNotEmpty(params,'orderId',$('#orderId').val())
        setIfNotEmpty(params,'erpOrderId',$('#erpOrderId').val())
        setIfNotEmpty(params,'refundId',$('#refundId').val())
        setIfNotEmpty(params,'userPin',$('#userPin').val())
        setIfNotEmpty(params,'refundStatus',$("#refundStatus").val())
        setIfNotEmpty(params,'createdFrom',$('#createdFrom').val())
        setIfNotEmpty(params,'createdTo',$('#createdTo').val())
        params.pageNum=pageNumber

        $.post('/refundManager/listData', params, function (data) {
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

    var reset=function(){
        $('#orderId').val('')
        $('#erpOrderId').val('')
        $('#refundId').val('')
        $('#userPin').val('')
        $('#refundStatus').val('')
        $('#createdFrom').val('')
        $('#createdTo').val('')
    }
</script>
</body>
</html>