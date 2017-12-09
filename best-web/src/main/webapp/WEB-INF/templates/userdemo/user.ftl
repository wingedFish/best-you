<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>user demo</title>
    <style>
        .outer {
            margin-top: 20px;
        }
    </style>
    <script src="http://misc.360buyimg.com//jdf/??lib/jquery-1.6.4.js,/1.0.0/unit/base/1.0.0/base.js"></script>
</head>
<body>
<div class="outer">
    <input type="button" value="获取用户(异步)" id="findUserById"/><br/>
    <div>返回内容：<span id="findUserByIdTarget"></span></div>
</div>
<div class="outer">
    用户名：<input type="text" id="userName"/> <input type="button" value="添加用户(异步)" id="addUser"/><br/>
    <div>返回内容：<span id="addUserTarget"></span></div>
</div>
<div class="outer">
    用户ID：<input type="text" id="delId"/> <input type="button" value="删除用户(异步)" id="delUser"/><br/>
    <div>返回内容：<span id="delUserTarget"></span></div>
</div>

<div class="outer">
    用户ID：<input type="text" id="updateId"/>
    用户name：<input type="text" id="updateName"/>
    <input type="button" value="更新(异步)" id="updateUser"/><br/>
    <div>返回内容：<span id="updateUserTarget"></span></div>
</div>

<div class="outer">
    <a href="/demo/user/list" target="_blank">有效用户列表</a>
</div>

<div class="outer">
    用户名:<input type="text" id="pageUserName"/>
    页码:<input type="text" id="startPage"/>
    <input id="pageButton" type="button" value="分页查询"/>
    <div>返回内容：<span id="pageTarget"></span></div>
</div>

<div class="outer">
    <a href="/demo/user/saveTransaction" target="_blank">事务测试</a>
</div>

<script>
    $("#findUserById").click(function () {
        $.get("/demo/user/json/3", function (data) {
            $("#findUserByIdTarget").html(JSON.stringify(data));
        })
    })

    $("#addUser").click(function () {
        $.post("/demo/user/", {"name": $("#userName").val()}, function (data) {
            $("#addUserTarget").html(JSON.stringify(data));
        })
    })

    $("#delUser").click(function () {
        $.post("/demo/user/" + $("#delId").val(), {"_method": "DELETE"}, function (data) {
            $("#delUserTarget").html(JSON.stringify(data));
        })
    })

    $("#updateUser").click(function () {
        $.post("/demo/user/" + $("#updateId").val(), {
            "name": $("#updateName").val(),
            "_method": "PUT"
        }, function (data) {
            $("#updateUserTarget").html(JSON.stringify(data));
        })
    })

    $("#pageButton").click(function () {
        $.get("/demo/user/list/page", {
            "name": $("#pageUserName").val(),
            "startPage": $("#startPage").val()
        }, function (data) {
            $("#pageTarget").html(JSON.stringify(data));
        })
    })

    $("#pageButtonip").click(function () {
        $.get("/order/pageList", {
            "name": $("#pageUserName").val(),
            "startPage": $("#startPage").val()
        }, function (data) {
            $("#pageTargetip").html(JSON.stringify(data));
        })
    })
</script>
</body>
</html>