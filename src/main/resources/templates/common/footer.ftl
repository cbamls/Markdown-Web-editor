<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>

<script src="${ctx}/js/main.js"></script> <!-- Resource jQuery -->

<script src="${ctx}/js/modernizr.js"></script> <!-- Modernizr -->
<!--[if IE]>
<script src="http://libs.baidu.com/html5shiv/3.7/html5shiv.min.js"></script>
<![endif]-->
<script src="https://www.layuicdn.com/layui/layui.js"></script>
<script src="${ctx}/js/modernizr.js"></script> <!-- Modernizr -->

<script src="${ctx}/js/title.js"></script>
<footer class="footer mt-20">
    <div>
        <nav><a href="#" target="_blank">关于我们</a> <span class="pipe">|</span> <a href="#"
                                                                                 target="_blank">联系我们</a> <span
                class="pipe">|</span><script type="text/javascript" src="https://s9.cnzz.com/z_stat.php?id=1278648988&web_id=1278648988"></script>
        </nav>
        <p>Copyright &copy;2020 www.6aiq.com All Rights Reserved. &nbsp;
            <a href="http://www.6aiq.com/" target="_blank" rel="nofollow"> 鲁ICP备18016225号</a><br>
        </p>
    </div>
</footer>

<div id="search" class="cd-main-search">
    <form>
        <input id="searchInput" type="search" placeholder="Search...">

    <#--<div class="cd-select">-->
    <#--<span>in</span>-->
    <#--<select name="select-category">-->
    <#--<option value="all-categories">all Categories</option>-->
    <#--<option value="category1">Category 1</option>-->
    <#--<option value="category2">Category 2</option>-->
    <#--<option value="category3">Category 3</option>-->
    <#--</select>-->
    <#--<span class="selected-value">all Categories</span>-->
    <#--</div>-->
    </form>

    <div class="cd-search-suggestions">
        <div class="news">
            <h3>我的文件</h3>
            <ul id="suggest">

            </ul>
            <ul id="content">
            <#if articles?? && userName??>
                <#list articles?keys as groupKey>
                <li>
                    <div style="display: inline-block">
                        <div style="display: inline-block">
                            <embed src="${ctx}/images/tag.svg" width="25" height="25" type="image/svg+xml"/>
                        </div>
                        <div style="display: inline-block">
                            <span style="font-size: 20px" id="my-tag-${groupKey}" onclick="showArticleList(`${groupKey}`)">${groupKey}</span>
                        </div>
                    </div>

                    <ul id="my-articles-${groupKey}" style="display: none">
                        <#list articles[groupKey] as item>
                            <li class="titleName">
                                <div class="layui-input-inline">
                                    <h4 class="layui-input-inline">
                                        <a class="cd-nowrap" href="/article/${item.id?c}"
                                           target="_blank">${item.title}</a>
                                    </h4>
                                    <time class="layui-input-inline" datetime="2016-01-12">${item.createTime}</time>
                                </div>
                            </li>
                        </#list>
                    </ul>
                </#list>
             <#else>
                    <img src="${ctx}/images/file.jpg">
            </#if>


            </ul>
        </div> <!-- .news -->
    </div> <!-- .cd-search-suggestions -->

    <a href="#0" class="close cd-text-replace">Close Form</a>
</div> <!-- .cd-main-search -->
<div class="cd-cover-layer"></div> <!-- cover main content when search form is open -->
