<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>db</title>
    <link rel="stylesheet" type="text/css" href="/static/css/index.css">
    <script type="text/javascript" src="/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/template.js"></script>
    <script type="text/javascript" src="/static/js/template.helper.js"></script>
    <style>
        table.border, .border tr, .border td, .border th {
            border: 1px solid;
            border-collapse: collapse;
        }
    </style>
</head>
<body>
<select id="whichDB">
    <option value="1">web</option>
    <option value="2">man</option>
</select><br/>
<textarea id="sqlEle" style="width: 800px;height: 200px"></textarea>
<div>
    <span style="margin-right: 20px"><input id="test" type="button" value="测试影响条数"/></span>
    <span style="margin-right: 20px"><input id="exec" type="button" value="执行"/></span>
    <span id="tip" style="font-size: 30px"></span>
</div>
<input type="text" id="dbKey1" style="border:0px"/>
<input type="text" id="dbKey2" style="border:0px"/>

<div id="ret"></div>

<script id="retTemplate" type="text/html">
    <table class="border">
        <tr>
            {{each columnName as column}}
            <th>{{column}}</th>
            {{/each}}
        </tr>
        {{each rows as r}}
        <tr>
            {{each r as field}}
            <td>{{field}}</td>
            {{/each}}
        </tr>
        {{/each}}
    </table>
</script>

<script>

    var urlPrefix = '/admin/dcd6a0ca5b7947e897fdd80a37c58031'
    $("#test").click(function () {
        var sql = $("#sqlEle").val();
        if (sql.indexOf("where") == -1) {
            alert("必须有where条件");
            return;
        }
        $("#tip").empty()
        $("#ret").empty()
        $.ajax({
            url: urlPrefix + '/test',
            type: 'POST',
            data: {
                "sql": $.trim(sql),
                "dbKey1":$.trim($("#dbKey1").val()),
                "dbKey2":$.trim($("#dbKey2").val()),
                "whichDB":$("#whichDB").val()
            },
            dataType: 'json',
            success: function (data, textStatus, jqXHR) {
                if (data.success === true) {
                    alert("执行成功")
                    $("#tip").html("影响条数:" + data.data.rowCount)
                } else {
                    alert("执行失败");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("执行失败");
            }
        });
    })

    $("#exec").click(function () {

        var sql = $("#sqlEle").val();
        if (sql.indexOf("where") == -1) {
            alert("必须有where条件");
            return;
        }
        $("#tip").empty()
        $("#ret").empty()
        $.ajax({
            url: urlPrefix + '/exec',
            type: 'POST',
            data: {
                "sql": $.trim(sql),
                "dbKey1":$.trim($("#dbKey1").val()),
                "dbKey2":$.trim($("#dbKey2").val()),
                "whichDB":$("#whichDB").val()
            },
            dataType: 'json',
            success: function (data, textStatus, jqXHR) {
                if (data.success === true) {
                    alert("执行成功")
                    $("#tip").html("影响条数:" + data.data.rowCount)
                    renderRet(data.data)
                } else {
                    alert("执行失败");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("执行失败");
            }
        });
    })

    var renderRet = function (data) {
        if (!data.columnName) {
            return;
        }
        var html = template('retTemplate', data);
        $("#ret").html(html);
    }

</script>
</body>
</html>