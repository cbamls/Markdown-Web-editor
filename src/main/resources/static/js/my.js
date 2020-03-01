$('#searchInput').keyup(function() {
    var value =  document.getElementById("searchInput").value;
    if (value.length <= 0) {
        $("#suggest").css("display", "none");
        $("#content").css("display", "block");
        return
    }
    var aList = $('.titleName div h4 a')
    var data = [];
    for (var i = 0; i<aList.length; i++) {
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
        $(".my-preview").css("margin-left", '5%');
        $(".my-preview").css("margin-right", '5%');
    }
    else {
        $(".my-preview").css("margin-left", '12%');
        $(".my-preview").css("margin-right", '12%');
    }
}

$(function () {
    resize();
    $(window).resize(function () {
        resize();
    })
});
$('#exportHtml').click(() => {
    alert($('#vditor').text())
});

layui.use('layer', function () {
    //鼠标悬停提示特效
    $("#help").hover(function () {
        openMsg("教程", "#help");
    }, function () {
        layui.layer.close(subtips);
    });
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
    $("#searcher").hover(function () {
        openMsg("搜索", "#searcher");
    }, function () {
        layui.layer.close(subtips);
    });
    //鼠标悬停提示特效
    $("#export").hover(function () {
        openMsg("导出", "#export");
    }, function () {
        layui.layer.close(subtips);
    });

});

function openMsg(msg, id) {
    subtips = layui.layer.tips(msg, id, {tips: [1, 'black'], time: 30000});
}

$("#release").click(function () {
    layer.open({
        type: 1,
        title: "<h3>发布哪里？</h3>",
        area: ['30%', '40%'],
        btn: ['确定', '取消'],
        content: $("#releaseSelect"),
        yes: function (index, layero) {
            var type = $('#releaseSelect input[name="saveType"]:checked').val();
            var data = {
                "id": $('#articleId').val(),
                "content": vditor.getValue(),
                "title": $('#name').val(),
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
})


