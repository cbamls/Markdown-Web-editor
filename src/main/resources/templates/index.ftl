<!doctype html>
<html lang="zh">
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
            <input type="text" id="Tags" value="输入后回车">
            <br><br><br>
            <H3>推荐标签</H3>
            <#if tags??>
                <#list tags as tag>
                    <div id="tag-${tag}" onclick="clickTag('${tag}')" class="tagItem2">${tag}</div>
                </#list>
            </#if>
        </div>
        <div id="placeholder" style="display: none">

## Guide

这是一篇讲解如何正确使用 **Markdown** 的排版示例，学会这个很有必要，能让你的文章有更佳清晰的排版。

> 引用文本：Markdown is a text formatting syntax inspired

## 语法指导

### 普通内容

这段内容展示了在内容里面一些排版格式，比如：

- **加粗** - `**加粗**`
- *倾斜* - `*倾斜*`
- ~~删除线~~ - `~~删除线~~`
- `Code 标记` - `` `Code 标记` ``
- [超级链接](https://hacpai.com) - `[超级链接](https://hacpai.com)`
- [username@gmail.com](mailto:username@gmail.com) - `[username@gmail.com](mailto:username@gmail.com)`

### 提及用户

@Vanessa 通过 `@User` 可以在内容中提及用户，被提及的用户将会收到系统通知。

> NOTE:
>
> 1. @用户名之后需要有一个空格
> 2. 新手没有艾特的功能权限

### 表情符号 Emoji

支持大部分标准的表情符号，可使用输入法直接输入，也可手动输入字符格式。通过输入 `:` 触发自动完成，可在个人设置中[设置常用表情](https://hacpai.com/settings/function)。

#### 一些表情例子

:smile: :laughing: :dizzy_face: :sob: :cold_sweat: :sweat_smile:  :cry: :triumph: :heart_eyes: :relieved:
:+1: :-1: :100: :clap: :bell: :gift: :question: :bomb: :heart: :coffee: :cyclone: :bow: :kiss: :pray: :anger:

### 大标题 - Heading 3

你可以选择使用 H1 至 H6，使用 ##(N) 打头。建议帖子或回帖中的顶级标题使用 Heading 3，不要使用 1 或 2，因为 1 是系统站点级，2 是帖子标题级。

> NOTE: 别忘了 # 后面需要有空格！

#### Heading 4

##### Heading 5

###### Heading 6

### 图片

```
![alt 文本](http://image-path.png)
![alt 文本](http://image-path.png "图片 Title 值")
```

支持复制粘贴直接上传。

### 代码块

#### 普通

```
*emphasize*    **strong**
_emphasize_    __strong__
var a = 1
```

#### 语法高亮支持

如果在 ``` 后面跟随语言名称，可以有语法高亮的效果哦，比如:

##### 演示 Go 代码高亮

```go
package main

import "fmt"

func main() {
	fmt.Println("Hello, 世界")
}
```

##### 演示 Java 高亮

```java
public class HelloWorld {

    public static void main(String[] args) {
        System.out.println("Hello World!");
    }

}
```

> Tip: 语言名称支持下面这些: `ruby`, `python`, `js`, `html`, `erb`, `css`, `coffee`, `bash`, `json`, `yml`, `xml` ...

### 有序、无序、任务列表

#### 无序列表

- Java
  - Spring
    - IoC
    - AOP
- Go
  - gofmt
  - Wide
- Node.js
  - Koa
  - Express

#### 有序列表

1. Node.js
   1.1. Express
   1.2. Koa
   1.3. Sails
2. Go
   2.1. gofmt
   2.2. Wide
3. Java
   3.1. Latke
   3.2. IDEA

#### 任务列表

- [x] 发布 Sym
- [X] 发布 Solo
- [ ] 预约牙医

### 表格

如果需要展示数据什么的，可以选择使用表格。

| header 1 | header 3 |
| -------- | -------- |
| cell 1   | cell 2   |
| cell 3   | cell 4   |
| cell 5   | cell 6   |

### 隐藏细节

<details>
<summary>这里是摘要部分。</summary>
这里是细节部分。
</details>

### 段落

空行可以将内容进行分段，便于阅读。（这是第一段）

使用空行在 Markdown 排版中相当重要。（这是第二段）

### 数学公式

多行公式块：

$$
\frac{1}{
  \Bigl(\sqrt{\phi \sqrt{5}}-\phi\Bigr) e^{
  \frac25 \pi}} = 1+\frac{e^{-2\pi}} {1+\frac{e^{-4\pi}} {
    1+\frac{e^{-6\pi}}
    {1+\frac{e^{-8\pi}}{1+\cdots}}
  }
}
$$

行内公式：

公式 $a^2 + b^2 = \color{red}c^2$ 是行内。

### 流程图

```mermaid
graph TB
    c1-->a2
    subgraph one
    a1-->a2
    end
    subgraph two
    b1-->b2
    end
    subgraph three
    c1-->c2
    end
```

### 时序图

```mermaid
sequenceDiagram
    Alice->>John: Hello John, how are you?
    loop Every minute
        John-->>Alice: Great!
    end
```

### 甘特图

```mermaid
gantt
    title A Gantt Diagram
    dateFormat  YYYY-MM-DD
    section Section
    A task           :a1, 2019-01-01, 30d
    Another task     :after a1  , 20d
    section Another
    Task in sec      :2019-01-12  , 12d
    another task      : 24d
```

### 图表

```echarts
{
  "title": { "text": "最近 30 天" },
  "tooltip": { "trigger": "axis", "axisPointer": { "lineStyle": { "width": 0 } } },
  "legend": { "data": ["帖子", "用户", "回帖"] },
  "xAxis": [{
      "type": "category",
      "boundaryGap": false,
      "data": ["2019-05-08","2019-05-09","2019-05-10","2019-05-11","2019-05-12","2019-05-13","2019-05-14","2019-05-15","2019-05-16","2019-05-17","2019-05-18","2019-05-19","2019-05-20","2019-05-21","2019-05-22","2019-05-23","2019-05-24","2019-05-25","2019-05-26","2019-05-27","2019-05-28","2019-05-29","2019-05-30","2019-05-31","2019-06-01","2019-06-02","2019-06-03","2019-06-04","2019-06-05","2019-06-06","2019-06-07"],
      "axisTick": { "show": false },
      "axisLine": { "show": false }
  }],
  "yAxis": [{ "type": "value", "axisTick": { "show": false }, "axisLine": { "show": false }, "splitLine": { "lineStyle": { "color": "rgba(0, 0, 0, .38)", "type": "dashed" } } }],
  "series": [
    {
      "name": "帖子", "type": "line", "smooth": true, "itemStyle": { "color": "#d23f31" }, "areaStyle": { "normal": {} }, "z": 3,
      "data": ["18","14","22","9","7","18","10","12","13","16","6","9","15","15","12","15","8","14","9","10","29","22","14","22","9","10","15","9","9","15","0"]
    },
    {
      "name": "用户", "type": "line", "smooth": true, "itemStyle": { "color": "#f1e05a" }, "areaStyle": { "normal": {} }, "z": 2,
      "data": ["31","33","30","23","16","29","23","37","41","29","16","13","39","23","38","136","89","35","22","50","57","47","36","59","14","23","46","44","51","43","0"]
    },
    {
      "name": "回帖", "type": "line", "smooth": true, "itemStyle": { "color": "#4285f4" }, "areaStyle": { "normal": {} }, "z": 1,
      "data": ["35","42","73","15","43","58","55","35","46","87","36","15","44","76","130","73","50","20","21","54","48","73","60","89","26","27","70","63","55","37","0"]
    }
  ]
}
```

### 五线谱

```abc
X: 24
T: Clouds Thicken
C: Paul Rosen
S: Copyright 2005, Paul Rosen
M: 6/8
L: 1/8
Q: 3/8=116
R: Creepy Jig
K: Em
|:"Em"EEE E2G|"C7"_B2A G2F|"Em"EEE E2G|\
"C7"_B2A "B7"=B3|"Em"EEE E2G|
"C7"_B2A G2F|"Em"GFE "D (Bm7)"F2D|\
1"Em"E3-E3:|2"Em"E3-E2B|:"Em"e2e gfe|
"G"g2ab3|"Em"gfeg2e|"D"fedB2A|"Em"e2e gfe|\
"G"g2ab3|"Em"gfe"D"f2d|"Em"e3-e3:|
```

### 多媒体

支持 v.qq.com，youtube.com，youku.com，coub.com，facebook.com/video，dailymotion.com，.mp4，.m4v，.ogg，.ogv，.webm，.mp3，.wav 链接解析

https://v.qq.com/x/cover/zf2z0xpqcculhcz/y0016tj0qvh.html

## 快捷键

我们的编辑器支持很多快捷键，具体请参考 [键盘快捷键](https://hacpai.com/article/1474030007391)（或者按 "`?` ":smirk_cat:）
        </div>
        <div style="position: fixed;right: -23px;top: 70px;}">
            <input type="checkbox" id="checkbox_d2" class="chk_4" checked /><label for="checkbox_d2"></label>
        </div>
        <div id="main-article">
            <div class="input">
                <label for="article-title" style="line-height: 60px; font-size: 24px; font-weight: 300; top: 10px;">标题:</label>
                <input type="text" name="name" id="article-title">
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
<#--            <button type="button" onclick="ex()"> 下载</button>-->
            <div id="vditor">

            </div>

        </div>
    </div>
</div>
<#include "/common/footer.ftl">

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
    $('#exportImg').click(function(event){
        layui.use('layer', function () {
                layer.msg("请 发布 后再导出");
            }
        )
    });
    $('#exportPDF').click(function(event){
        layui.use('layer', function () {
                layer.msg("请 发布 后再导出");
            }
        )
    });
    $(function () {
        var theme = localStorage.getItem("theme")
        if (theme === 'dark') {
            $("#checkbox_d2").removeAttr("checked")
        } else {
            $("#checkbox_d2").prop("checked", 'true')
        }
        vditor.setTheme(theme)
    })
    let headers = {Authorization: 'token'};
    const vditor = new Vditor('vditor', {
        typewriterMode: true,
        counter: 100,
        preview: {
            markdown: {
                toc: true,
            },
        },
        toolbar: [
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
        after: e => {
            if ((vditor.getValue() === undefined || vditor.getValue().length < 2) && (localStorage.getItem("vditorvditor") == undefined
                || localStorage.getItem("vditorvditor").length < 2)) {
                vditor.setValue(document.getElementById("placeholder").textContent)
            }
            $("#article-title").val(localStorage.getItem("titleValue"))
            $("#loading").remove();
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


    $(function save_auto() {
        //初始化已有标签
        var tag1 = new Tag("Tags");
        tag1.tagValue = "";
        tag1.initView();

        var spanObj = document.getElementById('s1');
        var d = new Date();
        var saveTimer = setInterval(function () {
            var str = "";
            str = $('#article-title').val()
            if (str != undefined && str.length > 1) {
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