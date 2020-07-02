# 水墨-在线 Markdown 编辑器

基于 Spring-boot、FreeMarker、layui、Vditor 构建的一款在线 **所见即所得**的 Markdown 编辑器。[水墨-在线Markdown编辑器](https://www.md6s.com)。本人使用 Vditor 编辑器时日已久，眼看着其功能日益强大，特此基于 Vditor 构建一款 Web 编辑器，愿为天下文人墨客贡献微不足道的力量。

> 此项目正在陆续开源，疫情期间代码仓促，会陆续迭代优化。

# ChangeLogs
* [ ]    后台代码重构
* [ ]    i18n支持
* [ ]    Github第三方登陆支持
* [ ] HTTPS 支持，解决 编辑器录音文件 输入
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

* 所见即所得编辑模式
* 支持任务列表、at、图表、流程图、甘特图、时序图、五线谱、[多媒体](https://link.hacpai.com/forward?goto=https%3A%2F%2Fgithub.com%2FVanessa219%2Fvditor%2Fissues%2F5)、语音阅读、标题锚点渲染
* 支持[**快捷键**](https://hacpai.com/article/1582778815353)操作
* 支持 Markdown **格式化**， Markdown **语法树**实时渲染
* **表情**自动补全，设置常用表情，支持表情自定义
* 自定义**工具栏**按钮、提示、插入字符、快捷键，支持工具栏添加按钮
* 可使用拖拽、剪切板粘贴上传，显示实时上传进度，支持 CORS 跨域上传
* 实时保存内容，防止意外丢失
* 录音支持，用户可直接**发布语音**
* 粘贴 HTML **自动转换**为 Markdown，如粘贴中包含外链图片可通过指定接口上传到服务器
* 提供实时预览、滚动同步定位
* 支持主窗口大小拖拽、字符计数
* 多主题支持、内置黑白两套
* 多语言支持、内置中英文
* 支持主流浏览器和移动端

# 功能截图

![image.png](http://rna.6aiq.com/image-7bc7fff88ee848ccac660348d6bf1682.png)
![image.png](http://rna.6aiq.com/image-378719a92132466984bddc5f7fe42977.png)

# 特别鸣谢

[Vditor编辑器](https://github.com/Vanessa219/vditor)
