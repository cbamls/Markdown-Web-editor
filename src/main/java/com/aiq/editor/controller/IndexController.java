package com.aiq.editor.controller;

import com.aiq.editor.auth.JwtUtil;
import com.aiq.editor.repo.Article;
import com.aiq.editor.repo.ArticleRepository;
import com.aiq.editor.service.QiNiuService;
import com.alibaba.fastjson.JSON;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class IndexController {
    private Logger LOGGER = LoggerFactory.getLogger(getClass());

    @Value("true")
    private Boolean qiniuEnable;

    @Autowired
    private ArticleRepository articleRepository;

    @Autowired
    private QiNiuService qiNiuService;

    @RequestMapping("/")
    public String tree(Map<Object, Object> map, HttpServletRequest request, HttpServletResponse response) {
        LOGGER.info("首页请求进入");
        String token = (String) request.getAttribute("access_token");
        if (JwtUtil.checkLogin(token)) {
            LOGGER.info("用户已登陆：{}", JwtUtil.getUsername(token));
            List<Article> articles = articleRepository.findArticlesByUserIdIs(JwtUtil.getUserId(token));
            Map<String, List<Article>> articleMap = new HashMap<>();
            for (Article article : articles) {
                for (String tag : article.getTags().split(",")) {
                    if (articleMap.get(tag) != null) {
                        articleMap.get(tag).add(article);
                    } else {
                        List<Article> l = new LinkedList<>();
                        l.add(article);
                        articleMap.put(tag, l);
                    }
                }
            }
            map.put("articles", articleMap);
        }
        return "index";
    }
    @RequestMapping("/help")
    public String preview(Map<Object, Object> map, HttpServletRequest request, HttpServletResponse response) {
        String token = (String) request.getAttribute("access_token");
        if (JwtUtil.checkLogin(token)) {
            LOGGER.info("{} 用户已登陆", JwtUtil.getUsername(token));
        }
        return "help";
    }


    @PostMapping("/api/upload/editor")
    @ResponseBody
    public Map<String, Object> multiUpload(Map<Object, Object> map, HttpServletRequest request) throws FileNotFoundException {
        List<MultipartFile> files = ((MultipartHttpServletRequest) request).getMultiFileMap().get("file[]");

        Map<String, Object> innerM = new HashMap<>();
        Map<String, Object> successMap = new HashMap<>();
        Map<String, Object> m = new HashMap<>();

        List<String> errList = new ArrayList<>();
        for (int i = 0; i < files.size(); i++) {
            MultipartFile file = files.get(i);
            String fileName = file.getOriginalFilename();

            if (qiniuEnable) {
                String token = (String) request.getAttribute("access_token");
                String res = qiNiuService.saveImage(file, token);
                LOGGER.info("上传的路径:{}", res);
                if (res != null) {
                    successMap.put(fileName, res);
                } else {
                    errList.add(fileName);
                    successMap.put(fileName, request.getAttribute("ctx") + "/images/img404.png");
                }
                continue;
            }
            File upload = new File("/opt/upload");
            if (!upload.exists()) {
                upload.mkdirs();
            }

            SimpleDateFormat format = new SimpleDateFormat("/yyyy/MM/dd");

            File newFile = new File(upload.getAbsolutePath(), format.format(new Date()));
            if (!newFile.exists()) {
                newFile.mkdirs();
            }
            String newFileName = String.valueOf(System.currentTimeMillis()) + '.' + fileName.substring(fileName.lastIndexOf('.') + 1, fileName.length());

            File dest = new File(newFile.getAbsolutePath() + '/' + newFileName);

            try {
                file.transferTo(dest);

                successMap.put(fileName, request.getAttribute("ctx") + "/images" + format.format(new Date()) + '/' + newFileName);
                LOGGER.info("第" + (i + 1) + "个文件上传成功");
                m.put("msg", "您的文件上传成功!");
                m.put("code", 0);
                m.put("data", innerM);
            } catch (IOException e) {
                errList.add(fileName);
                LOGGER.error("失败的上传:", e);
            }
        }
        m.put("msg", "您的文件上传成功!");
        m.put("code", 0);
        m.put("data", innerM);
        innerM.put("errFiles", errList);
        innerM.put("succMap", successMap);
        return m;

    }
}
