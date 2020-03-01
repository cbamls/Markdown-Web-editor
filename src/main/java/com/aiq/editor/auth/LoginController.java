package com.aiq.editor.auth;

import com.aiq.editor.common.MdResponse;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
public class LoginController {
    private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private UserRepository userRepository;

    @RequestMapping("/showLogin")
    public String showLogin(Map<String, Object> map, HttpServletRequest request) {
        return "auth";
    }

    @RequestMapping("/api/login")
    @ResponseBody
    public MdResponse login(@RequestBody User user, HttpServletResponse response, HttpServletRequest request) {
        LOGGER.info("登陆信息:{}", user);
        if (StringUtils.isEmpty(user.getEmail()) || StringUtils.isEmpty(user.getPassword())) {
            return new MdResponse(400, "请检查参数", null);
        }
        String token = (String) request.getAttribute("access_token");
        if (JwtUtil.checkLogin(token)) {
            return new MdResponse(400, "用户已登陆", null);
        }

        User dbUser = userRepository.findByEmail(user.getEmail().trim());
        if (dbUser != null) {
            if (!dbUser.getPassword().equals(user.getPassword())) {
                return new MdResponse(400, "密码错误，请重试", null);
            }
            String userID = StringUtils.isEmpty(dbUser.getName()) ? dbUser.getEmail() : dbUser.getName();
            String createToken = JwtUtil.sign(userID, String.valueOf(dbUser.getId()));
            final Cookie cookie = new Cookie("access_token", createToken);

            cookie.setPath("/");
            cookie.setMaxAge(60 * 60 * 24 * 7);
            cookie.setHttpOnly(true); // HTTP Only
            response.addCookie(cookie);
            return new MdResponse(200, "登陆成功", token);
        }
        return new MdResponse(400, "该邮箱尚未注册", null);
    }

    @RequestMapping("/api/register")
    @ResponseBody
    public MdResponse register(@RequestBody User user) {
        LOGGER.info("注册信息:{}", user);
        if (StringUtils.isEmpty(user.getEmail()) || StringUtils.isEmpty(user.getPassword())) {
            return new MdResponse(400, "请检查参数", null);
        }
        User dbUser = userRepository.findByEmail(user.getEmail().trim());
        if (dbUser != null) {
            return new MdResponse(400, "该邮箱已注册，请登陆", null);
        }
        user.setRole("normal");
        userRepository.save(user);
        return new MdResponse(200, "注册成功", null);
    }

    @RequestMapping("/api/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        String token = (String) request.getAttribute("access_token");
        if (JwtUtil.checkLogin(token)) {
            LOGGER.info("{} 用户已退出", JwtUtil.getUsername(token));
            final Cookie cookie = new Cookie("access_token", "");
            cookie.setPath("/");
            cookie.setMaxAge(1);
            cookie.setHttpOnly(true); // HTTP Only
            response.addCookie(cookie);
        }
        return "redirect:/";
    }

}
