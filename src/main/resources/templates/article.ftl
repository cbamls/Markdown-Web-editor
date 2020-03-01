<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<#include "/common/meta.ftl">
    <link href="${ctx}/css/shadow.css" rel="stylesheet">

</head>
<body>
<div class="wrapper">

<#include "/common/header.ftl"/>
    <div class="input">
        <label for="name" style="line-height: 60px; font-size: 24px; font-weight: 300; top: 10px;">标题:</label>
        <input type="text" name="name" id="name" value="${title}">
        <span class="spin" style="width: 0px;"></span>
    </div>
    <div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>正文</legend>
        </fieldset>
        <div id="preview">
            <div style="margin-top: 15px">
                <div id="loading" style="margin: 0 auto; text-align: center; height: 600px;"><img
                        src="${ctx}/images/loading.gif">
                </div>
            </div>
        </div>
    </div>

    <textarea id="markdownText" class="preview" style="display:none;">
${article}
    </textarea>



<#include "/common/footer.ftl"/>
</div>
<script src="https://cdn.jsdelivr.net/npm/vditor@2.1.5/dist/index.min.js"></script>
<script src="${ctx}/js/my.js"></script>

<script>
    $(function () {
        $("label", this).css({
            "line-height": "18px",
            "font-size": "18px",
            "font-weight": "80",
            "top": "0px"
        })
    })

    layui.use('element', function () {
        var element = layui.element;

        //监听导航点击
        element.on('nav(demo)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());
        });
    });

    Vditor.preview(document.getElementById('preview'),
            document.getElementById('markdownText').textContent, {
                className: 'preview vditor-reset vditor-reset--anchor my-preview shadow4',
                customEmoji: {
                    'sd': '💔',
                    'j': 'https://unpkg.com/vditor@1.3.1/dist/images/emoji/j.png',
                },
                speech: {
                    enable: true,
                },
                anchor: true
            })
</script>
</body>
</html>
