<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Train admin</title>
    <link rel="icon" href="//www.jd.com/favicon.ico" mce_href="//www.jd.com/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="/static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="/static/css/index.css">
    <script type="text/javascript" src="/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/appjs/index.js"></script>
    <script>
        function isChrome() {
            var isChromium = window.chrome,
                    winNav = window.navigator,
                    vendorName = winNav.vendor,
                    isOpera = winNav.userAgent.indexOf("OPR") > -1,
                    isIEedge = winNav.userAgent.indexOf("Edge") > -1,
                    isIOSChrome = winNav.userAgent.match("CriOS");

            if (isIOSChrome) {
                return true;
            } else if (isChromium !== null && isChromium !== undefined && vendorName === "Google Inc." && isOpera == false && isIEedge == false) {
                return true;
            } else {
                return false;
            }
        }

        if (!isChrome()) {
            alert("请使用chrome浏览器");
            window.location.href = "https://www.google.com/chrome/browser/desktop/index.html"
        }
    </script>
</head>
<body>
<div class="easyui-layout" fit="true" border="true">
    <div data-options="region:'north'" style="height:50px;text-align: center">
        <h2>Train admin&nbsp;&nbsp;&nbsp;<input type="button" value="close all tab" onclick="closeAllTab()">
    </div>
    <div data-options="region:'south',split:true" style="height:50px;"></div>
    <div data-options="region:'west',split:true" title="menu" style="width:200px;">

        <div class="easyui-accordion" data-options="fit:false,border:false">
        <#include "index_menu.ftl">
        </div>

    </div>
    <div data-options="region:'center',iconCls:'icon-ok'">
        <div id="content" class="easyui-tabs" data-options="fit:true,border:false,plain:true">

        </div>
    </div>
</div>
<script>
    var closeAllTab = function () {
        var len = $('#content').tabs('tabs').length;
        for (var i = len - 1; i >= 0; i--) {
            $('#content').tabs('close', i);
        }
    }


</script>
</body>
</html>