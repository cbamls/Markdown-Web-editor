function exportPDF() {
    layui.use('layer', function () {
            layer.msg("亲～，正在导出中...")
        }
    )

    var element = document.getElementById('export-pdf');

    var name = $('#article-title').val().length > 0 ? $('#article-title').val() : getNowTime() + ".pdf";
    var opt = {
        filename: name,
        image: {type: 'jpeg', quality: 1},
        html2canvas: {
            margin: 1,
            scale: 1,
            useCORS: true,
        },
       // pagebreak: {avoid: 'p'},
        jsPDF: {unit: 'in', format: 'letter', orientation: 'portrait'}
    };
    html2pdf().set(opt).from(element).save();

}

function exportImg() {
    layui.use('layer', function () {
            layer.msg("亲～，正在导出中...")
        }
    )
    var element = $("#export-pdf"); // 这个dom元素是要导出pdf的div容器

    var rect = element.get(0).getBoundingClientRect();

    var promise = html2canvas(element[0], {
        useCORS: true,
        scale: 1,
        height: rect.height,
        width: rect.width,
        y: -1,
        // canvas: canvas,
        //dpi: window.devicePixelRatio * 1, // window.devicePixelRatio是设备像素比
    })
    Promise.all([promise]).then(function ([canvas]) {
        var dataUrl = canvas.toDataURL('image/jpeg', 1.0);
        $("#downloadImg").attr("href", dataUrl)
        $("#downloadImg").attr("download", $('#article-title').val().length > 0 ? $('#article-title').val() : getNowTime())
        $("#downloadImg").append("<span></span>");
        $("#downloadImg span").click();
        $("#downloadImg span").remove()
        $("#downloadImg").attr("href", "javascript:;")

    })
}

function getNowTime() {
    var date = new Date();
    this.year = date.getFullYear();
    this.month = date.getMonth() + 1;
    this.date = date.getDate();
    this.hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
    this.minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
    this.second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
    this.milliSeconds = date.getMilliseconds();
    var currentTime = this.year + '-' + this.month + '-' + this.date + ' ' + this.hour + ':' + this.minute + ':' + this.second + '.' + this.milliSeconds;
    return currentTime;
}

$("#img-store").click(function () {
    layui.use('layer', function () {
            layer.msg("开发中...")
        }
    )
})

$('#searchInput').keyup(function () {
    var value = document.getElementById("searchInput").value;
    if (value.length <= 0) {
        $("#suggest").css("display", "none");
        $("#content").css("display", "block");
        return
    }
    var aList = $('.titleName div h4 a')
    var data = [];
    for (var i = 0; i < aList.length; i++) {
        var contents = aList[i].innerHTML;
        if (contents.indexOf(value) != -1) {
            var contents = aList[i].innerHTML;
            if (contents.indexOf(value) != -1) {
                var values = contents.split(value);
                var a = $('.titleName div h4 a').eq(i).clone(true);
                values = values.join('<span style="color:red;">' + value + '</span>');
                var text = '<a class="cd-nowrap" href=' + '\"' + $(a).attr("href") + '\">' + values + '</a>'
                var li = '<li>\n' +
                    '                                <div class="layui-input-inline">\n' +
                    '                                    <h4 class="layui-input-inline">\n' +
                    text +
                    '                                   </h4>\n' +
                    '                                </div>\n' +
                    '                            </li>'
                data.push(li);
            }
        }
    }
    $("#suggest").html(data);
    $("#suggest").css("display", "block");
    $("#content").css("display", "none");
});

function showArticleList(groupKey) {
    var value = $('#my-articles-' + groupKey).css('display')
    if (value === 'none') {
        $('#my-articles-' + groupKey).css('display', 'block')
    } else {
        $('#my-articles-' + groupKey).css('display', 'none')
    }
}

function resize() {
    var _width = $(window).width();
    if (_width < 712) {
        $("#main-article").css("margin-left", '5%');
        $("#my-preview").css("margin-right", '5%');
    } else {
        $("#main-article").css("margin-left", '19%');
        $("#main-article").css("margin-right", '19%');
    }
}

$(function () {
    resize();
    $(window).resize(function () {
        resize();
    })
});

layui.use('layer', function () {
//鼠标悬停提示特效
//     $("#help").hover(function () {
//         openMsg("教程", "#help");
//     }, function () {
//         layui.layer.close(subtips);
//     });
//鼠标悬停提示特效
    $("#release").hover(function () {
        openMsg("发布", "#release");
    }, function () {
        layui.layer.close(subtips);
    });
//鼠标悬停提示特效
    $("#release").hover(function () {
        openMsg("编辑", "#edit");
    }, function () {
        layui.layer.close(subtips);
    });
//鼠标悬停提示特效
    $("#github").hover(function () {
        openMsg("开源地址", "#github");
    }, function () {
        layui.layer.close(subtips);
    });
//鼠标悬停提示特效
    $("#searcher").hover(function () {
        openMsg("搜索", "#searcher");
    }, function () {
        layui.layer.close(subtips);
    });
//鼠标悬停提示特效
//     $("#export").hover(function () {
//         openMsg("导出", "#export");
//     }, function () {
//         layui.layer.close(subtips);
//     });
});

function openMsg(msg, id) {
    subtips = layui.layer.tips(msg, id, {tips: [1, 'black'], time: 30000});
}

$("#release").click(function () {
        layer.open({
            type: 1,
            title: "<h3>发布哪里？</h3>",
            area: ['40%', '50%'],
            btn: ['确定', '取消'],
            content: $("#releaseSelect"),
            yes: function (index, layero) {
                var type = $('#releaseSelect input[name="saveType"]:checked').val();
                var data = {
                    "id": $('#articleId').val(),
                    "content": vditor.getValue(),
                    "title": $('#article-title').val(),
                    "tags": tagTake.getAllTags(),
                    "publishType": type
                }
                $.ajax({
                    type: "POST",//方法类型
                    headers: {'Content-Type': 'application/json;charset=utf8'},
                    dataType: "json",//预期服务器返回的数据类型
                    url: "/api/publish",//url
                    data: JSON.stringify(data),
                    success: function (result) {
                        if (result.code == 200) {
                            layer.alert('发布成功', {icon: 1, title: '发布成功提示'}, function (i) {
                                layer.close(i);
                                layer.close(index);
                            })
                            window.location = "/article/" + result.data
                        } else if (result.code == 403) {
                            layui.use('layer', function () {
                                layui.layer.msg(result.msg)
                            });
                            setTimeout(function () {
                                window.location = "/showLogin"
                            }, 2000);
                        } else {
                            layui.use('layer', function () {
                                layui.layer.msg(result.msg)
                            });
                        }
                    },
                    error: function () {
                        layui.use('layer', function () {
                            layui.layer.msg("发布失败了，请联系管理员！")
                        });
                    }
                });
            }
        });
    }
)

$("#checkbox_d2").click(function (e) {
    var theme = localStorage.getItem("theme")
    if (theme === undefined || theme === '') {
        vditor.setTheme("dark")
        localStorage.setItem("theme", "dark")
    } else {
        if (theme === 'dark') {
            vditor.setTheme("light")
            localStorage.setItem("theme", "light")
        } else {
            vditor.setTheme("dark")
            localStorage.setItem("theme", "dark")
        }
    }
})


