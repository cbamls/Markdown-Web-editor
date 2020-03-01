<!doctype html>
<html lang="zh" class="no-js">
<head>
<#include "/common/meta.ftl">
</head>
<body>
<div class="wrapper">
<#include "/common/header.ftl">
    <div class="main">
        <div id="releaseSelect" class="layui-input-block" style="display: none">
            <strong>对外发布：</strong><input type="radio" name="saveType" value="public" title="public" checked>
            &nbsp;&nbsp;
            <strong>私有发布：</strong><input type="radio" name="saveType" value="private" title="private">
            <br>
            <div style="color: rgba(0,0,0,.38);font-size: 12px;">
                对外发布后，其它人即可拜读您的笔墨～
            </div>
        </div>

        <div class="input">
            <label for="name" style="line-height: 60px; font-size: 24px; font-weight: 300; top: 10px;">标题:</label>
            <input type="text" name="name" id="name">
            <input type="text" name="id" id="articleId" style="display: none">
            <span class="spin" style="width: 0px;"></span>
        </div>
        <div style="text-align: center; margin-top: 2px">
        <#if !userName??>
            <div style="color: rgba(0,0,0,.38);font-size: 12px;">
                <a href="/showLogin"><span style="cursor: pointer; color: blue">登录</span></a>后可完整体验<b>上传</b>和<b>录音</b>功能
                &nbsp;<div id="s1" style="color: green; height: 10px"></div>
            </div>
        </#if>
            <div style="color: rgba(0,0,0,.38);font-size: 12px;">
                <div id="s1" style="color: green; height: 10px"></div>
            </div>

        </div>


        <div style="margin: 0 auto; margin-top: -10px; width: 90%">
            <div style="margin-top: 15px">
                <div id="loading" style="margin: 0 auto; text-align: center; height: 600px;"><img
                        src="${ctx}/images/loading.gif">
                </div>
            </div>
            <div id="your-article" style="display: none">
            <#if article??>
${article}

            </#if>
            </div>
            <div id="vditor">

            </div>

        </div>
    </div>
</div>
<#include "/common/footer.ftl">

<#--<main class="cd-main-content">-->
<#--<!-- your content here &ndash;&gt;-->
<#--<div class="content-center">-->
<#--<!-- <h1>Advanced Search Form</h1> &ndash;&gt;-->

<#--<h1>jQuery和CSS3炫酷高级搜索框设计效果</h1>-->
<#--<h2>点击右上角放大镜查看效果</h2>-->


<#--</div>-->
<#--</main>-->
<script src="https://cdn.jsdelivr.net/npm/vditor@2.1.5/dist/index.min.js"></script>

<script src="${ctx}/js/my.js"></script>
</body>

<script>

    layui.use('element', function () {
        var element = layui.element;

        //监听导航点击
        element.on('nav(demo)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());
        });
    });

    let headers = {Authorization: 'token'};
    const vditor = new Vditor('vditor', {
        typewriterMode: true,
        counter: 100,
        toolbar: [{
            hotkey: "⌘-e",
            name: "emoji",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-h",
            name: "headings",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-b",
            name: "bold",
            prefix: "**",
            suffix: "**",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-i",
            name: "italic",
            prefix: "*",
            suffix: "*",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-s",
            name: "strike",
            prefix: "~~",
            suffix: "~~",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-k",
            name: "link",
            prefix: "[",
            suffix: "](https://)",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-l",
            name: "list",
            prefix: "* ",
            tipPosition: "n",
        }, {
            hotkey: "⌘-o",
            name: "ordered-list",
            prefix: "1. ",
            tipPosition: "n",
        }, {
            hotkey: "⌘-j",
            name: "check",
            prefix: "* [ ] ",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-.",
            name: "quote",
            prefix: "> ",
            tipPosition: "n",
        }, {
            hotkey: "⌘-⇧-d",
            name: "line",
            prefix: "---",
            tipPosition: "n",
        }, {
            hotkey: "⌘-u",
            name: "code",
            prefix: "```\n",
            suffix: "\n```",
            tipPosition: "n",
        }, {
            hotkey: "⌘-g",
            name: "inline-code",
            prefix: "`",
            suffix: "`",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            name: "upload",
            tipPosition: "n",
        }, {
            name: "record",
            tipPosition: "n",
        }, {
            hotkey: "⌘-m",
            name: "table",
            prefix: "| col1",
            suffix: " | col2 | col3 |\n| --- | --- | --- |\n|  |  |  |\n|  |  |  |",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-z",
            name: "undo",
            tipPosition: "n",
        }, {
            hotkey: "⌘-y",
            name: "redo",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-⇧-m",
            name: "wysiwyg",
            tipPosition: "nw",
        }, {
            hotkey: "⌘-p",
            name: "both",
            tipPosition: "nw",
        }, {
            hotkey: "⌘-⇧-p",
            name: "preview",
            tipPosition: "nw",
        }, {
            hotkey: "⌘-⇧-f",
            name: "format",
            tipPosition: "nw",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-'",
            name: "fullscreen",
            tipPosition: "nw",
        }, {
            name: "devtools",
            tipPosition: "nw",
        }
//            , {
//                name: "info",
//                tipPosition: "nw",
//            }
            , {
                name: "toHelp",
                tipPosition: "nw",
                tip: "帮助文档",
                tipPosition: "nw",
                icon: '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32"> <path d="M19.652 25v6c0 0.55-0.45 1-1 1h-6c-0.55 0-1-0.45-1-1v-6c0-0.55 0.45-1 1-1h6c0.55 0 1 0.45 1 1zM27.552 10c0 4.75-3.225 6.575-5.6 7.9-1.475 0.85-2.4 2.575-2.4 3.3v0c0 0.55-0.425 1.2-1 1.2h-6c-0.55 0-0.9-0.85-0.9-1.4v-1.125c0-3.025 3-5.625 5.2-6.625 1.925-0.875 2.725-1.7 2.725-3.3 0-1.4-1.825-2.65-3.85-2.65-1.125 0-2.15 0.35-2.7 0.725-0.6 0.425-1.2 1.025-2.675 2.875-0.2 0.25-0.5 0.4-0.775 0.4-0.225 0-0.425-0.075-0.625-0.2l-4.1-3.125c-0.425-0.325-0.525-0.875-0.25-1.325 2.7-4.475 6.5-6.65 11.6-6.65 5.35 0 11.35 4.275 11.35 10z"></path> </svg>',
                click: (e) => {
                    window.open("/edit/1581793131")
                },
            }, {
                name: "br",
            }],
        after: e => {
            <#--var title = localStorage.getItem("titleValue");-->
            <#--alert("ss")-->
            <#--if (title != null) {-->
                <#--if (title === '${title}') {-->
                    <#--$("#name").val(title)-->
                <#--} else {-->
                    <#--console.log("title已被修改过" + title + " 数据库中: " + '${title}')-->
                    <#--$("#name").val(title)-->
                <#--}-->
            <#--} else {-->
                <#--console.log("title为空")-->
                <#--$("#name").val(`${title}`)-->
            <#--}-->
            <#--var title = vditor.getValue();-->
            <#--alert(title)-->
            <#--if (title != null) {-->
                <#--if (title === '${title}') {-->
                    <#--$("#name").val(title)-->
                <#--} else {-->
                    <#--console.log("title已被修改过" + title + " 数据库中: " + '${title}')-->
                    <#--$("#name").val(title)-->
                <#--}-->
            <#--} else {-->
                <#--console.log("title为空")-->
                <#--$("#name").val(`${title}`)-->
            <#--}-->
            //vditor.setValue(document.getElementById('your-article').textContent)
            document.getElementById('your-article').innerHTML = "";
            $("#loading").remove();
        },
        height: 580,
        hint: {
            emojiPath: 'https://cdn.jsdelivr.net/npm/vditor@1.8.3/dist/images/emoji',
            emojiTail: '<a href="https://hacpai.com/settings/function" target="_blank">设置常用表情</a>',
            emoji: {
                'sd': '💔',
                "+1": "👍",
                "-1": "👎",
                "cold_sweat": "😰",
                "heart": "❤️",
                'j': 'https://unpkg.com/vditor@1.3.1/dist/images/emoji/j.png',
            },
        },
        tab: '\t',
        upload: {
            accept: 'image/*,.wav,.jpg,.png,.gif,.jpeg',
            max: 10 * 1024 * 1024,
            token: 'test',
            cache: true,
            preview: {
                delay: 5000,
                mode: 'both',
                parse: element => {
                    alert("预览")
                    if (element.style.display === 'none') {
                        return;
                    }
                    //LazyLoadImage();
                    vditor.highlightRender(
                            {
                                style: 'github',
                                enable: true
                            },
                            document
                    );
                }
            },
            headers: headers,
            url: '/api/upload/editor',
            linkToImgUrl: '/api/upload/fetch',
            filename(name) {
                return name.replace(/[^(a-zA-Z0-9\u4e00-\u9fa5\.)]/g, '').replace(/[\?\\/:|<>\*\[\]\(\)\$%\{\}@~]/g, '').replace('/\\s/g', '')
            }
        },
    })
    $(function save_auto() {
        var spanObj = document.getElementById('s1');
        var d = new Date();
        var saveTimer = setInterval(function () {
            var str = "";
            str = $('#name').val()
            if (str.length > 1) {
                localStorage.setItem("titleValue", str);
                var d = new Date();
                var YMDHMS = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" +
                        d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
                spanObj.innerText = '自动保存中... ' + YMDHMS;
                setTimeout(function () {
                    spanObj.innerText = '';
                }, 3000);
            }
        }, 5000)
    })
</script>
</html>