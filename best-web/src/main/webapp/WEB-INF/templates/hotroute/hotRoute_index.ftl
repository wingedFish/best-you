<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>hot line</title>
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
    </style>
    <script>
        var allHotRoutes =${allHotRoutes}
        var cities =${cities}
    </script>
</head>
<body>
<form id="imgFormEle">
    <input type="file" id="imgFileEle" name="upfile" style="display: none" onchange="imgChange()"/>
</form>
<table class="border">
    <tr>
        <th>NO</th>
        <th>picture</th>
        <th>from station</th>
        <th>to station</th>
        <th>lowest price</th>
        <th>operation</th>
    </tr>
    <tbody id="stationTbody">

    </tbody>
</table>

<script id="stationSelectTemplate" type="text/html">
    {{each cities as c }}
    <optgroup label="{{c.cityName}}">
        {{each c.stations as s}}
        <option value="{{s.stationCode}}">{{s.stationName}}</option>
        {{/each}}
    </optgroup>
    {{/each}}
</script>
<script id="stationTrTemplate" type="text/html">
    <tr>
        <td>
            {{index+1}}
        </td>
        <td>
            <img id="images_{{index}}" style="width: 100px;height: 100px" onclick="showUploadImg({{index}})"/>
        </td>
        <td>
            <select style="width:200px" id="startStation_{{index}}">
                <option>...</option>
                {{#stationHtml}}
            </select>
        </td>
        <td>
            <select style="width:200px" id="toStation_{{index}}">
                <option>...</option>
                {{#stationHtml}}
            </select>
        </td>
        <td>
            <input type="text" id="lowestPrice_{{index}}"/>
            <input type="button" value="get price" onclick="getLowestPrice({{index}})"/>
        </td>
        <td>
            <input type="button" value="save" onclick="save({{index}})"/>
        </td>
    </tr>
</script>

<script type="text/javascript" src="/static/js/business/hotRoute.js"></script>
</body>
</html>