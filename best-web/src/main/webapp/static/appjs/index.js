var openTab = function (url, title) {
    if (!url) {
        alert("没有传递URL");
        return;
    }
    if (!title) {
        alert("没有传递title");
        return;
    }
    var $content = $("#content")
    /*if ($('#content').tabs('exists', title)) {
        var $iframe=$('iframe',$('#content'));
        var originUrl=$iframe.attr('originUrl')o
        $iframe[0].contentWindow.location.href=originUrl;
    } else*/ {
        var content = '<iframe scrolling="auto" originUrl="'+url+'" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
        $('#content').tabs('add', {
            title: title,
            content: content,
            closable: true
        });
    }
}