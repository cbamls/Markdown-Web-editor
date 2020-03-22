package com.aiq.editor.common;

import com.aiq.editor.auth.JwtUtil;
import com.aiq.editor.repo.Article;
import com.aiq.editor.repo.ArticleRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class AppInterceptor implements HandlerInterceptor {

    private static final Logger LOGGER = LoggerFactory.getLogger(AppInterceptor.class);

    @Autowired
    private ArticleRepository articleRepository;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        try {
            String scheme = httpServletRequest.getScheme();
            String serverName = httpServletRequest.getServerName();
            String basePath = scheme + "://" + serverName + ":8081";
            httpServletRequest.setAttribute("ctx", basePath);
            if (httpServletRequest.getCookies() != null) {
                for (Cookie cookie : httpServletRequest.getCookies()) {
                    if (cookie.getName().equals("access_token")) {
                        httpServletRequest.setAttribute("access_token", cookie.getValue());
                        if (JwtUtil.checkLogin(cookie.getValue()))
                            httpServletRequest.setAttribute("userName", JwtUtil.getUsername(cookie.getValue()));
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.error("拦截器异常", e);
        }
        return true;
    }
}
