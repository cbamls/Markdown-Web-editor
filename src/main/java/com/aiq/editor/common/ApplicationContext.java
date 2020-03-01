package com.aiq.editor.common;

import com.aiq.editor.auth.JwtUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class ApplicationContext implements HandlerInterceptor {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApplicationContext.class);

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        LOGGER.info("进入拦截器");
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
