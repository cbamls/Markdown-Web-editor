<!DOCTYPE html>
<html>
<head>
    <#include "/common/meta.ftl">

    <link href="${ctx}/css/index.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/css/auth.css">
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui/css/layui.css"/>
</head>

<body>
<#include "/common/header.ftl"/>

<div class="lowin lowin-purple">
    <div class="lowin-brand">
        <img src="${ctx}/images/logo.jpeg" alt="logo">
    </div>
    <div class="lowin-wrapper">
        <div class="lowin-box lowin-login">
            <div class="lowin-box-inner">
                <form id="form" onsubmit="return false" action="##" method="post">
                    <p>Sign in to continue</p>
                    <div class="lowin-group">
                        <label>邮箱： <a href="#" class="login-back-link">Sign in?</a></label>
                        <input type="email" autocomplete="email" name="email" class="lowin-input">
                    </div>
                    <div class="lowin-group password-group">
                        <label>密码 <a href="#" class="forgot-link">Forgot Password?</a></label>
                        <input type="password" name="password" autocomplete="current-password"
                               lay-verify="required|password" class="lowin-input">
                        <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
                    </div>

                    <button class="lowin-btn login-btn" onclick="login()">
                        登陆
                    </button>

                    <div class="text-foot">
                        还没有账户? <a href="" class="register-link">注册</a>
                    </div>
                </form>
            </div>
        </div>

        <div class="lowin-box lowin-register">
            <div class="lowin-box-inner">
                <form id="registerForm" onsubmit="return false" action="##" method="post">
                    <p>创建账户</p>
                    <div class="lowin-group">
                        <label>昵称：</label>
                        <input type="text" name="name" autocomplete="off" lay-verify="required|username"
                               class="lowin-input">
                    </div>
                    <div class="lowin-group">
                        <label>邮箱：</label>
                        <input type="email" autocomplete="email" name="email" class="lowin-input">
                    </div>
                    <div class="lowin-group">
                        <label>密码</label>
                        <input type="password" name="password" autocomplete="current-password" class="lowin-input">
                        <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
                    </div>
                    <button class="lowin-btn" onclick="register()">
                        注册
                    </button>

                    <div class="text-foot">
                        已创建有账户? <a href="" class="login-link">登陆</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer class="lowin-footer">

    </footer>
<#include "/common/footer.ftl"/>

</div>
<script src="https://www.layuicdn.com/layui/layui.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script src="${ctx}/js/auth.js"></script>
<script>
    function checkName(value) {
        if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
            layui.use('layer', function () {
                layui.layer.msg('用户名不能为空或有特殊字符')
            });
            return false;
        }
        if (/(^\_)|(\__)|(\_+$)/.test(value)) {
            layui.use('layer', function () {
                layui.layer.msg('用户名首尾不能出现下划线\'_\'')
            });
            return false;
        }
        return true;
    }
    function checkEmail(value) {
        if (!new RegExp("/^([a-zA-Z]|[0-9])(\\w|\\-)+@[a-zA-Z0-9]+\\.([a-zA-Z]{2,4})$/").test(value)) {
            return false;
        }
        return true;
    }
    function checkPass(value) {
        if (!/^[A-Za-z0-9]{6,16}$/.test(value)) {
            layui.use('layer', function () {
                layui.layer.msg('密码必须6到12位，只能为字母数字下划线')
            });
            return false;
        }
        return true;
    }

    layui.use('element', function () {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

        //监听导航点击
        element.on('nav(demo)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());
        });
    });

    function register() {
        var formObject = {};
        var formArray = $("#registerForm").serializeArray();
        var check = true;
        $.each(formArray, function (i, item) {
            if(item.name === 'name') {
                if (!checkName(item.value)) {
                    check = false;
                }
            }
            if (item.name === 'password') {
                if (!checkPass(item.value)) {
                    check = false;
                }
            }
            if (item.name === 'email') {
                if (!checkEmail(item.value)) {
                    check = false;
                }
            }
            formObject[item.name] = item.value;
        });
        if (!check) {
            return ;
        }
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            headers: {'Content-Type': 'application/json;charset=utf8'},
            dataType: "json",//预期服务器返回的数据类型
            url: "/api/register",//url
            data: JSON.stringify(formObject),
            success: function (result) {
                console.log(result);//打印服务端返回的数据(调试用)
                if (result.code == 200) {
                    layui.use('layer', function () {
                        layui.layer.msg(result.msg)
                    });
                    window.location = "/showLogin"
                } else {
                    layui.use('layer', function () {
                        layui.layer.msg(result.msg)
                    });
                }
            },
            error: function () {
                layui.use('layer', function () {
                    layui.layer.msg("请求失败了，请联系管理员！")
                });
            }
        });
    }

    function login() {
        var formObject = {};
        var formArray = $("#form").serializeArray();
        $.each(formArray, function (i, item) {
            formObject[item.name] = item.value;
        });
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            headers: {
                'Content-Type': 'application/json;charset=utf8',
                'access_token': getCookie("access_token")
            },
            dataType: "json",//预期服务器返回的数据类型
            url: "/api/login",//url
            data: JSON.stringify(formObject),
            success: function (result) {
                console.log(result);//打印服务端返回的数据(调试用)
                if (result.code == 200) {
                    layui.use('layer', function () {
                        layui.layer.msg(result.msg)
                    });
                    var exp = new Date();
                    //24*60*60*1000
                    exp.setTime(exp.getTime() + 60 * 60 * 1000);
                    document.cookie = "access_token=" + result.data + ";expires=" + exp.toGMTString();
                    window.location = "/"
                } else {
                    layui.use('layer', function () {
                        layui.layer.msg(result.msg)
                    });
                }
            },
            error: function () {
                layui.use('layer', function () {
                    layui.layer.msg("请求失败，请联系管理员！")
                });
            }
        });
    }

    function getCookie(name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
        if (arr = document.cookie.match(reg))
            return (arr[2]);
        else
            return null;
    }

    Auth.init({
        login_url: '/api/login',
        forgot_url: '/api/forgot'
    });


</script>
</body>
</html>