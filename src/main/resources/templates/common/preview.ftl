<html>
<meta charset="utf-8"/>

<head>
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
    <script language="JavaScript" type="text/JavaScript">
        /**
         弹出iframe页面(iframe后面会添加灰色蒙版)
         **/
        function showIframe(content) {
            $("<div id='showMobilePreview'>" +
                "<div class='mobile_preview_header'><i class='mobile_preview_header_icon'></i></div>" +
                "<div class='mobile_preview_frame'>" + content + "</div>" +
                "<div class='mobile_preview_footer'><i class='mobile_preview_footer_icon'></i></div>" +
                "</div>").prependTo('body');

            //添加背景遮罩
            $("<div id='YuFrameMobilePreviewBg' style='cursor:pointer;width:100%;height:100%;background-color: Gray;display:block;z-index:9998;position:absolute;left:0px;top:0px;filter:Alpha(Opacity=30);/* IE */-moz-opacity:0.4;/* Moz + FF */opacity: 0.4; '/>").prependTo('body');

            //点击背景遮罩移除iframe和背景
            $("#YuFrameMobilePreviewBg").click(function () {
                $("#showMobilePreview").remove();
                $("#YuFrameMobilePreviewBg").remove();
            });
        }
    </script>
    <link rel="stylesheet" href="/Users/liangshu/IdeaProjects/nb-editor/src/main/resources/static/templete/green.css">
    <!-- Resource style -->

    <style type="text/css">

    </style>
</head>
<body>
<input type="button" onClick="showIframe('https://m.baidu.com')" value="加载"/>
</body>
<html>
