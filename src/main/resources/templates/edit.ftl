<!doctype html>
<html>
<head>
    <#include "/common/meta.ftl">
</head>
<body>
<div class="wrapper">
    <#include "/common/header.ftl">

    <div class="main">
        <div id="releaseSelect" class="layui-input-block" style="display: none; text-align: center; margin-left: 0px;">
            <strong>对外发布：</strong><input type="radio" name="saveType" value="public" title="public" checked>
            &nbsp;&nbsp;
            <strong>私有发布：</strong><input type="radio" name="saveType" value="private" title="private">
            <br>
            <div style="color: rgba(0,0,0,.38);font-size: 12px;">
                对外发布后，其它人即可拜读您的笔墨～
            </div>
            <br><br>
            <H3>文章标签</H3>
            <input type="text" id="Tags" placeholder="输入后回车">
            <br><br><br>
            <H3>使用过的标签</H3>
            <#if tags??>
                <#list tags as tag>
                    <div id="tag-${tag}" onclick="clickTag('${tag}')" class="tagItem2">${tag}</div>
                </#list>
            </#if>
        </div>
        <div style="position: fixed;right: -23px;top: 70px;}">
            <input type="checkbox" id="checkbox_d2" class="chk_4" checked /><label for="checkbox_d2"></label>
        </div>
        <div id="main-article">
            <div class="input">
                <label for="article-title" style="line-height: 60px; font-size: 24px; font-weight: 300; top: 10px;">标题:</label>
                <input type="text" name="name" id="article-title">
                <input type="text" name="id" id="articleId" style="display: none" value="${articleId?c}">
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
        </div>

        <div style="margin: 0 auto; margin-top: -10px; width: 90%">
            <div style="margin-top: 15px">
                <div id="loading" style="margin: 0 auto; text-align: center; height: 600px;"><img
                            src="${ctx}/images/loading.gif">
                </div>
            </div>
            <div id="your-article" style="display: none">
                <#if article??>
${article.content}
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

</body>
<script src="${ctx}/js/my.js"></script>

<script>

    layui.use('element', function () {
        var element = layui.element;

        //监听导航点击
        element.on('nav(demo)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());
        });
    });
    $('#exportImg').click(function (event) {
        layer.msg("请 发布 后再导出");
    });
    $('#exportPDF').click(function (event) {
        layer.msg("请 发布 后再导出");
    });
    $(function () {
        var theme = localStorage.getItem("theme")
        if (theme === 'dark') {
            $("#checkbox_d2").removeAttr("checked")
        } else {
            $("#checkbox_d2").prop("checked", 'true')
        }
        vditor.setTheme(theme)
        //初始化已有标签
        var tag1 = new Tag("Tags");
        tag1.tagValue = "${article.tags}";
        tag1.initView();
    })
    var id = ${articleId?c};
    var dbs;
    let headers = {Authorization: 'token'};
    const vditor = new Vditor('vditor', {
        typewriterMode: true,
        counter: 100,
        cache: false,
        preview: {
            markdown: {
                toc: true,
            },
        },
        toolbar:[
            {
                name: "toHelp",
                tipPosition: "nw",
                tip: "帮助文档",
                tipPosition: "nw",
                icon: '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32"> <path d="M19.652 25v6c0 0.55-0.45 1-1 1h-6c-0.55 0-1-0.45-1-1v-6c0-0.55 0.45-1 1-1h6c0.55 0 1 0.45 1 1zM27.552 10c0 4.75-3.225 6.575-5.6 7.9-1.475 0.85-2.4 2.575-2.4 3.3v0c0 0.55-0.425 1.2-1 1.2h-6c-0.55 0-0.9-0.85-0.9-1.4v-1.125c0-3.025 3-5.625 5.2-6.625 1.925-0.875 2.725-1.7 2.725-3.3 0-1.4-1.825-2.65-3.85-2.65-1.125 0-2.15 0.35-2.7 0.725-0.6 0.425-1.2 1.025-2.675 2.875-0.2 0.25-0.5 0.4-0.775 0.4-0.225 0-0.425-0.075-0.625-0.2l-4.1-3.125c-0.425-0.325-0.525-0.875-0.25-1.325 2.7-4.475 6.5-6.65 11.6-6.65 5.35 0 11.35 4.275 11.35 10z"></path> </svg>',
                click: (e) => {
                    window.open("/edit/1581793131")
                }
            }
        ],
        input: (value, preview)  => {
            console.log("sync..." + vditor.getValue())
            if ($("#article-title").val() !== '' && vditor.getValue() != '') {
                dbs.delete("articles",${articleId?c},{
                    success:function () {
                        dbs.add("articles", {
                            'id': ${articleId?c},
                            'title':$("#article-title").val(),
                            'content': vditor.getValue()
                        },{
                            success:function () {},
                            complete:function(e){},
                            error:function(e){}
                        })
                    },
                    complete:function(e){},
                    error:function(e){}
                })

            }

        },
        after: e => {
            dbs=new IndexedDb('mdeditor',{
                connUpgrade: function (self) {      //首次连接或数据库版本更新时触发
                    self.createTable("articles",'id',{ //当需要创建表时需要更新版本来触发connUpgrade方法，connUpgrade回调外调用createTable来创建表的方法是错误的
                        success:function (objectStore) {

                        }
                    })
                },
                connSuccess:function (self) {     //连接成功回掉数据库操作类实例
                    console.log("查找ID:" + id)
                    if (id === undefined) {
                        $("#article-title").val(`${title}`)
                        vditor.setValue(document.getElementById('your-article').textContent)
                        dbs.add("articles",{
                            'id': ${articleId?c},
                            'title':'${title}',
                            'content': document.getElementById('your-article').textContent
                        },{
                            success:function () {},
                            complete:function(e){},
                            error:function(e){}
                        })
                    } else {
                        dbs.get("articles",id,{
                            success:function (result) {
                                if (result !== undefined) {
                                    //console.log(result.content.trim() + " ++++++++++++ " + document.getElementById('your-article').textContent.trim() + " endddd")
                                    if ( result.content.trim() !== document.getElementById('your-article').textContent.trim()) {
                                        layer.open({
                                            type: 1,
                                            title: "<h3>系统监测到您之前的数据尚未保存</h3>",
                                            area: ['30%', '14%'],
                                            closeBtn: 0,
                                            btn: ['放弃本次修改', '加载未保存数据'],
                                            yes: function (index, layero) {
                                                $("#article-title").val(`${title}`)
                                                vditor.setValue(document.getElementById('your-article').textContent)
                                                $("#loading").css("display", "none");
                                                layer.close(index);
                                                dbs.delete("articles",${articleId?c},{
                                                    success:function () {
                                                    },
                                                    complete:function(e){},
                                                    error:function(e){}
                                                })
                                            }, btn2: function(index, layero){
                                                $("#article-title").val(result.title)
                                                vditor.setValue(result.content)
                                                $("#loading").css("display", "none");
                                            }
                                        });
                                    } else {
                                        $("#article-title").val(`${title}`)
                                        vditor.setValue(document.getElementById('your-article').textContent)
                                        $("#loading").css("display", "none");
                                    }
                                } else {
                                    $("#article-title").val(`${title}`)
                                    vditor.setValue(document.getElementById('your-article').textContent)
                                    $("#loading").css("display", "none");

                                    dbs.add("articles",{
                                        'id': ${articleId?c},
                                        'title':$("#article-title").val(),
                                        'content': document.getElementById('your-article').textContent
                                    },{
                                        success:function () {},
                                        complete:function(e){},
                                        error:function(e){}
                                    })
                                }
                            },
                            complete:function(e){},
                            error:function(e){
                                console.log(e)
                                $("#article-title").val(`${title}`)
                                vditor.setValue(document.getElementById('your-article').textContent)
                                $("#loading").css("display", "none");
                            }
                        })
                    }
                },
                connError:function(e){ //如果连接失败
                    console.log(e)
                }
            })


        },
        height: 580,
        hint: {
            emojiPath: 'https://cdn.jsdelivr.net/npm/vditor@1.8.3/dist/images/emoji',
            emojiTail: '<a href="https://hacpai.com/settings/function" target="_blank">设置常用表情</a>',
            delay: 200,
            emoji: {
                "+1": "👍",
                "-1": "👎",
                "confused": "😕",
                "eyes": "👀️",
                "heart": "❤️",
                "rocket": "🚀️",
                "smile": "😄",
                "tada": "🎉️",
            },
            emojiPath: `https://cdn.jsdelivr.net/npm/vditor@latest/dist/images/emoji`,
        },
        tab: '\t',
        toolbar: [{
            hotkey: "⌘-E",
            name: "emoji",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-H",
            name: "headings",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-B",
            name: "bold",
            prefix: "**",
            suffix: "**",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-I",
            name: "italic",
            prefix: "*",
            suffix: "*",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-S",
            name: "strike",
            prefix: "~~",
            suffix: "~~",
            tipPosition: "ne",
        }, {
            hotkey: "⌘-K",
            name: "link",
            prefix: "[",
            suffix: "](https://)",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-L",
            name: "list",
            prefix: "* ",
            tipPosition: "n",
        }, {
            hotkey: "⌘-O",
            name: "ordered-list",
            prefix: "1. ",
            tipPosition: "n",
        }, {
            hotkey: "⌘-J",
            name: "check",
            prefix: "* [ ] ",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-;",
            name: "quote",
            prefix: "> ",
            tipPosition: "n",
        }, {
            hotkey: "⌘-⇧-D",
            name: "line",
            prefix: "---",
            tipPosition: "n",
        }, {
            hotkey: "⌘-U",
            name: "code",
            prefix: "```\n",
            suffix: "\n```",
            tipPosition: "n",
        }, {
            hotkey: "⌘-G",
            name: "inline-code",
            prefix: "`",
            suffix: "`",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-⇧-U",
            name: "upload",
            tipPosition: "n",
        }, {
            name: "record",
            tipPosition: "n",
        }, {
            hotkey: "⌘-M",
            name: "table",
            prefix: "| col1",
            suffix: " | col2 | col3 |\n| --- | --- | --- |\n|  |  |  |\n|  |  |  |",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-Z",
            name: "undo",
            tipPosition: "n",
        }, {
            hotkey: "⌘-Y",
            name: "redo",
            tipPosition: "n",
        }, {
            name: "|",
        }, {
            hotkey: "⌘-⇧-M",
            name: "edit-mode",
            tipPosition: "nw",
        }, {
            hotkey: "⌘-P",
            name: "both",
            tipPosition: "nw",
        }, {
            hotkey: "⌘-⇧-P",
            name: "preview",
            tipPosition: "nw",
        }, {
            hotkey: "⌘-⇧-F",
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
            // , {
            //     name: "info",
            //     tipPosition: "nw",
            // }
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
        upload: {
            accept: 'image/*,.wav,.jpg,.png,.gif,.jpeg',
            max: 10 * 1024 * 1024,
            token: 'test',
            cache: true,

            headers: headers,
            url: '/api/upload/editor',
            linkToImgUrl: '/api/upload/fetch',
            filename(name) {
                return name.replace(/[^(a-zA-Z0-9\u4e00-\u9fa5\.)]/g, '').replace(/[\?\\/:|<>\*\[\]\(\)\$%\{\}@~]/g, '').replace('/\\s/g', '')
            }
        },
    })
    window.onbeforeunload =function () {
        console.log("close db conn")
        dbs.close()
    };
</script>
</html>