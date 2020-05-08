
<header class="cd-main-header animate-search">
    <div class="cd-logo">
        <a href="/" style="text-decoration: none">
           <h1 style="margin: 0">
               <img src="${ctx}/images/logo.jpeg" alt="在线 Markdown 编辑器" class="my-img-style"/>
               <strong id="head-text" style="font-size: 20px;padding-left: 20px;"> 水墨 </strong>
               <strong style="font-size: 15px">- 在线 Markdown 编辑器</strong>
           </h1>
        </a>
    </div>
    <nav class="cd-main-nav-wrapper">

        <ul class="layui-nav layui-layout-right my-layui-bg">
            <li class="layui-nav-item" lay-unselect="">
            <#if userName??>
                <span style="font-size: 15px;color: black;">您好：</span><strong
                    style="font-size: 18px;color: black;">${userName}</strong> &nbsp;
                <dl class="layui-nav-child">
                    <dd lay-unselect><a href="/api/logout"><strong>退出</strong></a></dd>
                </dl>
            <#else>
                <a href="/showLogin"><i class="layui-icon layui-icon-user"
                                        style="font-size: 25px; color: black;"></i></a>
            </#if>

            </li>
            <li class="layui-nav-item">
                <div>
                    <a id="searcher" style="background-color: black; border-radius:20px; margin-top: 10px; margin-bottom: 13px" href="#search"
                       class="cd-search-trigger cd-text-replace">
                    </a>
                </div>
            </li>


<#--            <li class="layui-nav-item">-->
<#--                <a href="/help">-->
<#--                    <i class="layui-icon layui-icon-help" id="help" style="font-size: 25px; color: black;"></i>-->
<#--                </a>-->
<#--            </li>-->
            <li class="layui-nav-item" id="my-github">
                <a href="https://github.com/cbamls/Markdown-Web-editor" target="_blank">
                    <img src="${ctx}/images/github.gif" style="height: 40px">
                </a>
            </li>
            <#if editable??>
                <li class="layui-nav-item">
                    <a href="/edit/${id?c}" id="edit">
                        <i class="layui-icon layui-icon-edit" style="font-size: 25px; color: black;"></i>
                    </a>
                </li>
                <#else>
                    <li class="layui-nav-item">
                        <i id="release" class="layui-icon layui-icon-release" style="font-size: 25px; color: black;"></i>
                    </li>
            </#if>

            <li class="layui-nav-item">
                <a href="">
                    <i class="layui-icon layui-icon-export" id="export" style="font-size: 25px; color: black;"></i>
                </a>
                <dl class="layui-nav-child layui-anim layui-anim-upbit"
                    style="left: auto;right: -22px;text-align: center;">
                    <dd lay-unselect>
                        <a id="importMD" href="javascript:;" style="text-decoration: none" onclick="importMD()">
                            <input type="file" name = "file" id = "mdFile" style="display: none"/>
                            <strong >导入MD</strong>
                        </a>
                    </dd>
                    <dd lay-unselect>
                        <a id="exportMD" href="javascript:;" style="text-decoration: none" onclick="downLoadMD(vditor.getValue(),
                        $('#article-title').val().length > 0 ? $('#article-title').val() : getNowTime())">
                            <strong >导出MD</strong>
                        </a>
                    </dd>
                    <dd lay-unselect>
                        <a id="exportPDF" href="javascript:;" style="text-decoration: none">
                        <#--<i class="layui-icon layui-icon-download-circle"-->
                        <#--style="font-size: 25px; vertical-align: middle; color: black;">-->
                        <#--</i>-->
                            <strong >导出PDF</strong>
                        </a>
                    </dd>
                    <dd lay-unselect>
                        <a id="downloadImg" href="javascript:;" download="" style="text-decoration: none">
                        <#--<i class="layui-icon layui-icon-download-circle"-->
                        <#--style="font-size: 25px; vertical-align: middle; color: black;"></i>-->
                            <strong id="exportImg">导出图片</strong>
                        </a>
                    </dd>
                    <dd lay-unselect>
                        <a id="exportWX" href="javascript:;" style="text-decoration: none">
                            <#--<i class="layui-icon layui-icon-download-circle"-->
                            <#--style="font-size: 25px; vertical-align: middle; color: black;">-->
                            <#--</i>-->
                            <strong >复制到微信</strong>
                        </a>
                    </dd>
                </dl>
            </li>

            <li class="layui-nav-item">
                <a href="">
                    <i class="layui-icon layui-icon-set" id="md-setting" style="font-size: 25px; color: black;"></i>
                </a>
                <dl class="layui-nav-child layui-anim layui-anim-upbit" style="left: auto; text-align: center;">
                    <dd lay-unselect>
                        <a href="javascript:;" style="text-decoration: none">
                            <strong id="img-store">设置图床</strong>
                        </a>
                    </dd>
                </dl>
            </li>
        </ul>
    </nav> <!-- .cd-main-nav-wrapper -->

    <a href="#0" class="cd-nav-trigger cd-text-replace">Menu<span></span></a>

</header>
