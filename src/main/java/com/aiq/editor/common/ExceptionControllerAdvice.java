package com.aiq.editor.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@RestControllerAdvice
public class ExceptionControllerAdvice {
    private static final Logger logger = LoggerFactory.getLogger(ExceptionControllerAdvice.class);

    @ExceptionHandler(Exception.class)
    public Object globalException(HttpServletRequest request, HandlerMethod handlerMethod, Throwable ex) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/error/4xx");
        return modelAndView;

    }
}
