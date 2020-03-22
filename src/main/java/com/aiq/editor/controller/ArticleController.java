package com.aiq.editor.controller;

import com.aiq.editor.auth.JwtUtil;
import com.aiq.editor.common.MdResponse;
import com.aiq.editor.repo.Article;
import com.aiq.editor.repo.ArticleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Controller
public class ArticleController {

    @Autowired
    private ArticleRepository articleRepository;

    @RequestMapping("/api/publish")
    @ResponseBody
    public MdResponse publish(@RequestBody Article article, HttpServletRequest request) {
        SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
        String token = (String) request.getAttribute("access_token");
        if (!JwtUtil.checkLogin(token)) {
            return new MdResponse(403, "请您登陆后再发布,您的内容不会丢失", null);
        }
        if (article.getTitle() == null && article.getContent() == null) {
            return new MdResponse(500, "内容或标题为空", null);
        }
        article.setUserId(JwtUtil.getUserId(token));
//        List<Article> articleList = articleRepository.find(article.getTitle(), article.getUserId());
//        if (article.getId() = null && articleList != null && !articleList.isEmpty()) {
//            return new MdResponse(405, "您发布过相同标题的文章", null);
//        }
        if (article.getId() == null) {
            Long articleId = System.currentTimeMillis() / 1000;
            article.setId(articleId);
            article.setCreateTime(format.format(new Date()));
            article.setUpdateTime(format.format(new Date()));
        } else {
            Article dbArticle = articleRepository.getOne(article.getId());
            article.setCreateTime(dbArticle.getCreateTime());
            article.setUpdateTime(format.format(new Date()));
        }
        article.setTheme("default");
        if (!(article.getTags() != null && article.getTags().length() > 0)) {
            article.setTags("未分类");
        } else {
            List<String> tagList = Arrays.asList(article.getTags().split(",")).stream().map(e -> e.trim()).collect(Collectors.toList());
            StringBuilder tagStr = new StringBuilder();
            for (int i = 0; i < tagList.size(); i++) {
                if (i == 0) {
                    tagStr.append(tagList.get(i));
                } else {
                    tagStr.append(",").append(tagList.get(i));
                }
            }
            article.setTags(tagStr.toString());
        }
        articleRepository.save(article);
        return new MdResponse(200, "发布成功", article.getId());
    }

    @RequestMapping("/article/{articleId}")
    public String article(@PathVariable("articleId") String articleId, HttpServletRequest request, Map<Object, Object> map) {
        Article article = articleRepository.getOne(Long.valueOf(articleId));
        if (article == null) {
            return "404";
        } else {
            if (!article.getPublishType().equals("public")) {
                return "404";
            }
            String token = (String) request.getAttribute("access_token");
            if (JwtUtil.checkLogin(token)) {
                List<Article> articles = articleRepository.findArticlesByUserIdIs(JwtUtil.getUserId(token));
                Map<String, List<Article>> articleMap = new HashMap<>();
                for (Article item : articles) {
                    for (String tag : item.getTags().split(",")) {
                        if (articleMap.get(tag) != null) {
                            articleMap.get(tag).add(item);
                        } else {
                            List<Article> l = new LinkedList<>();
                            l.add(article);
                            articleMap.put(tag, l);
                        }
                    }
                }
                map.put("articles", articleMap);
            }
            map.put("article", article);
            map.put("tags", Arrays.stream(article.getTags().split(",")).collect(Collectors.toList()));
            map.put("title", article.getTitle());
            map.put("id", article.getId());
            map.put("editable", "true");
            return "article";
        }
    }

    @RequestMapping("/edit/{articleId}")
    public String edit(@PathVariable("articleId") String articleId, HttpServletRequest request, Map<Object, Object> map) {
        String token = (String) request.getAttribute("access_token");
        if (!JwtUtil.checkLogin(token)) {
            return "redirect:/showLogin";
        }
        Article article = articleRepository.getOne(Long.valueOf(articleId));
        if (article == null) {
            return "404";
        } else {
            if (!article.getPublishType().equals("public")) {
                return "404";
            }
            List<Article> articles = articleRepository.findArticlesByUserIdIs(JwtUtil.getUserId(token));
            Map<String, List<Article>> articleMap = new HashMap<>();
            Set<String> tags = new HashSet<>();
            if (!CollectionUtils.isEmpty(articles)) {
                Stream<String> stream = articles.stream().map(Article::getTags).map(e -> e.split(",")).flatMap(x -> new HashSet<String>(Arrays.asList(x)).stream());
                tags = stream.collect(Collectors.toSet());
            }
            for (Article item : articles) {
                for (String tag : item.getTags().split(",")) {
                    if (articleMap.get(tag) != null) {
                        articleMap.get(tag).add(item);
                    } else {
                        List<Article> l = new LinkedList<>();
                        l.add(article);
                        articleMap.put(tag, l);
                    }
                }
            }
            for (String tag : article.getTags().split(",")) {
                if (tags.contains(tag)) {
                    tags.remove(tag);
                }
            }
            request.setAttribute("tags", tags);

            map.put("articles", articleMap);

            map.put("article", article);
            map.put("title", article.getTitle());
            map.put("articleId", article.getId());
            map.put("edit", "yes");
            return "edit";
        }
    }

//    @RequestMapping("/articles/{userId}")
//    @ResponseBody
//    public String articles(@PathVariable("userId") String userId, HttpServletRequest request) {
//        String token = (String) request.getAttribute("access_token");
//        if (!JwtUtil.checkLogin(token)) {
//            return "redirect:/showLogin";
//        }
//
//    }
}
