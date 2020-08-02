# 水墨-在线 Markdown 编辑器

基于 Spring-boot、FreeMarker、layui、Vditor 构建的一款在线 **所见即所得**的 Markdown 编辑器。[水墨-在线Markdown编辑器](https://www.md6s.com)。

# ChangeLogs
* [ ]    后台代码重构
* [ ]    i18n支持
* [ ]    Github第三方登陆支持
* [X]    升级Vditor 支持导出知乎、微信公众号
* [X] HTTPS 支持，解决 编辑器录音文件 输入
* [X] 03.23 支持标签功能 修复若干代码bug
* [X] 03.22 升级Vditor 到 V2.2.19，支持主题切换
* [X] 03.22 编辑页实时缓存变更，防止编辑数据丢失
* [X] 03.22 大文件导出 pdf 时，pdf 末尾出现空白页问题
* [X] 03.08 1.导出 PDF; 2. 导出高清图片；3. logo 居中缩小； 4.首页 title 数据回显
* [X] 03.01 fix 标题 Input 刷新页面时，div 和 header 重叠问题； fix 编辑器获取焦点时边框变色
* [X] 02.29 支持实时搜索个人文件
* [X] 02.16 文章详情页与文章编辑页
* [X] 02.15 登陆，注册功能
* [X] 02.09 技术调研，搭建项目
* [X] 02.07 Markdown 编辑器调研

# Feature Outline

![](http://rna.6aiq.com/image-c463a6d64b2940f199a873737ec412fd.png "image.png")

## ✨ 编辑器特性

* 支持三种编辑模式：所见即所得（wysiwyg）、即时渲染（ir）、分屏预览（sv）
* 支持大纲、数学公式、脑图、图表、流程图、甘特图、时序图、五线谱、[多媒体](https://hacpai.com/article/1589813914768)、语音阅读、标题锚点、代码高亮及复制、graphviz 渲染
* 内置安全过滤、导出、图片懒加载、任务列表、at、多平台预览、多主题切换、复制到微信公众号功能
* 实现 CommonMark 和 GFM 规范，可对 Markdown 进行格式化和语法树查看，并支持[10+项](https://hacpai.com/article/1549638745630#options-preview-markdown)配置
* 工具栏包含 36+ 项操作，除支持扩展外还可对每一项中的[快捷键](https://hacpai.com/article/1582778815353)、提示、提示位置、图标、点击事件、类名、子工具栏进行自定义
* 表情自动补全，设置常用表情，支持表情自定义
* 可使用拖拽、剪切板粘贴上传，显示实时上传进度，支持 CORS 跨域上传
* 实时保存内容，防止意外丢失
* 录音支持，用户可直接发布语音
* 粘贴 HTML 自动转换为 Markdown，如粘贴中包含外链图片可通过指定接口上传到服务器
* 支持主窗口大小拖拽、字符计数
* 多主题支持，内置黑白绿三套主题
* 多语言支持，内置中、英、韩文本地化
* 支持主流浏览器，对移动端友好

# 功能截图

![image.png](http://rna.6aiq.com/image-7bc7fff88ee848ccac660348d6bf1682.png)
![image.png](http://rna.6aiq.com/image-378719a92132466984bddc5f7fe42977.png)

# 特别鸣谢

[Vditor编辑器](https://github.com/Vanessa219/vditor)
