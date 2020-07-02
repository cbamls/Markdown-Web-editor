<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
    <#include "/common/meta.ftl">

    <title>${title} - 水墨在线Markdown编辑器</title>
    <link href="${ctx}/css/shadow.css" rel="stylesheet">
    <style>
        #outline {
            position: fixed;
            width: 290px;
            top: 20px;
            right: 20px;
            bottom: 20px;
            overflow: auto;
            font-size: 13px;
            border: 1px solid var(--border-color);
            border-radius: 3px;
            background-color: var(--textarea-background-color);
        }
    </style>
</head>
<body>
<div class="wrapper">

    <#include "/common/header.ftl"/>
    <div id="main-article">
        <div id="export-pdf">
            <div class="input">
                <label for="article-title"
                       style="line-height: 60px; font-size: 24px; font-weight: 300; top: 10px;">标题:</label>
                <input type="text" name="name" id="article-title" value="${title}" disabled>
                <span class="spin" style="width: 0px;"></span>
                <#if tags??>
                    <#list tags as tag>
                        <div id="tag-${tag}" onclick="clickTag('${tag}')" class="tagItem2">${tag}</div>
                    </#list>
                </#if>
            </div>
            <div>
                <div id="preview">
<#--                    <div style="margin-top: 15px">-->
<#--                        <div id="loading" style="margin: 0 auto; text-align: center; height: 600px;"><img-->
<#--                                    src="${ctx}/images/loading.gif">-->
<#--                        </div>-->
<#--                    </div>-->
                </div>
            </div>
        </div>
    </div>
    <textarea id="markdownText" class="preview" style="display:none;">
${article.content}
    </textarea>


</div>
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
    $('#exportImg').click(function (event) {
        event.stopPropagation();    //  阻止事件冒泡
        exportImg();
    });
    $('#exportPDF').click(function (event) {
        event.stopPropagation();    //  阻止事件冒泡
        exportPDF();
    });
    Vditor.preview(document.getElementById('preview'),
        document.getElementById('markdownText').textContent, {
            markdown: {
                toc: true
            },
            speech: {
                enable: true,
            },
            anchor: 1,
            after () {
                if (window.innerWidth <= 768) {
                    return;
                }
            },
            lazyLoadImage: 'https://cdn.jsdelivr.net/npm/vditor/dist/images/img-loading.svg',
        })
    $("#preview").css("font-variant", "normal")
    $("#preview").css("padding-right", "20px")
    $("#preview").css("padding-top", "20px")
    $("#preview").addClass("my-preview")
</script>
<#include "/common/footer.ftl"/>
</body>
</html>
