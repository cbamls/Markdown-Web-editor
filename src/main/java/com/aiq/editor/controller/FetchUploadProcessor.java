package com.aiq.editor.controller;

import com.aiq.editor.auth.JwtUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import jodd.http.HttpRequest;
import jodd.http.HttpResponse;
import jodd.net.MimeTypes;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
public class FetchUploadProcessor {
    public static final String UPLOAD_FILE_DIR = "/opt/upload/";

    @Value("${qiniu.enabled}")
    private Boolean qiniuEnable;

    // 设置好账号的ACCESS_KEY和SECRET_KEY
    String ACCESS_KEY = "mwFCI8T3obEgALQL4QIxcup_-iiCY11kfax1Bhh4";
    String SECRET_KEY = "tY6yFwXW48ZuqMyb8NeKlvvl9gQ_AMv92c-k713p";
    // 要上传的空间
    final String BUCKET_NAME = "spider";

    // 密钥配置
    Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
    // 构造一个带指定Zone对象的配置类,不同的七云牛存储区域调用不同的zone
    Configuration cfg = new Configuration(Zone.zone0());
    // ...其他参数参考类注释
    UploadManager uploadManager = new UploadManager(cfg);

    // 测试域名，只有30天有效期
    private static String QINIU_IMAGE_DOMAIN = "http://rna.6aiq.com/";

    /**
     * Logger.
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(FetchUploadProcessor.class);

    @PostMapping("/api/upload/fetch")
    @ResponseBody
    public Map<String, Object> fetchUpload(@RequestBody String urlNet, HttpServletRequest request) {
        JSONObject object = (JSONObject) JSON.parse(urlNet);
        String realUrl = object.getString("url");
        LOGGER.info("待上传的文件名:{}", realUrl);

        HttpResponse res = null;
        byte[] data;
        String contentType;
        try {
            final HttpRequest req = HttpRequest.get(realUrl);
            res = req.send();

            if (HttpServletResponse.SC_OK != res.statusCode()) {
                return buildFailed(request.getAttribute("ctx").toString(), realUrl);
            }

            data = res.bodyBytes();
            contentType = res.contentType();
        } catch (final Exception e) {
            LOGGER.error("Fetch file [url=" + realUrl + "] failed", e);
            return buildFailed(request.getAttribute("ctx").toString(), realUrl);
        } finally {
            if (null != res) {
                try {
                    res.close();
                } catch (final Exception e) {
                    LOGGER.error("Close response failed", e);
                }
            }
        }

        String suffix;
        String[] exts = MimeTypes.findExtensionsByMimeTypes(contentType, false);
        if (null != exts && 0 < exts.length) {
            suffix = exts[0];
        } else {
            suffix = StringUtils.substringAfter(contentType, "/");
        }

        final String fileName = "image-" + UUID.randomUUID().toString().replace("-", "") + "." + suffix;

        if (qiniuEnable) {
            try {
                // 调用put方法上传
                Response uploadRes;
                String token = (String) request.getAttribute("access_token");

                boolean admin = JwtUtil.checkLogin(token) && JwtUtil.getUsername(token).equals("cbam");
                if (admin) {
                    uploadRes = uploadManager.put(data, fileName, auth.uploadToken("aiqimg"));
                } else {
                    uploadRes = uploadManager.put(data, fileName, auth.uploadToken(BUCKET_NAME));
                }
                // 打印返回的信息
                if (uploadRes.isOK() && uploadRes.isJson()) {
                    String realPath;
                    if (admin) {
                        realPath = "http://img.6aiq.com/" + JSONObject.parseObject(uploadRes.bodyString()).get("key");
                    } else {
                        realPath = QINIU_IMAGE_DOMAIN + JSONObject.parseObject(uploadRes.bodyString()).get("key");
                    }
                    Map<String, Object> dataMap = new HashMap<>();
                    dataMap.put("originalURL", realUrl);
                    dataMap.put("url", realPath);
                    return buildSuccess(dataMap);
                } else {
                    LOGGER.error("七牛异常:" + uploadRes.bodyString());
                    return buildFailed(request.getAttribute("ctx").toString(), realUrl);
                }
            } catch (Exception e) {
                // 请求失败时打印的异常的信息
                LOGGER.error("七牛异常:" + e);
                return buildFailed(request.getAttribute("ctx").toString(), realUrl);
            }
        } else {
            try (final OutputStream output = new FileOutputStream(UPLOAD_FILE_DIR + fileName)) {
                IOUtils.write(data, output);
                SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");

                Map<String, Object> dataMap = new HashMap<>();
                dataMap.put("originalURL", realUrl);
                dataMap.put("url", request.getAttribute("ctx") + "/images/" + format.format(new Date()) + '/' + fileName);
                return buildSuccess(dataMap);
            } catch (final Exception e) {
                LOGGER.error("Writes output stream failed", e);
            }
        }
        return buildFailed(request.getAttribute("ctx").toString(), realUrl);
    }

    private Map<String, Object> buildSuccess(Map<String, Object> data) {
        Map<String, Object> res = new HashMap<>();
        res.put("msg", "您的文件上传成功!");
        res.put("code", 0);
        res.put("data", data);
        return res;
    }

    private Map<String, Object> buildFailed(String baseUrl, String originalURL) {
        Map<String, Object> res = new HashMap<>();
        Map<String, Object> innerM = new HashMap<>();

        res.put("data", innerM);
        res.put("code", 0);
        res.put("msg", "您的文件上传成功!");
        innerM.put("url", baseUrl + "/images/img404.png");
        innerM.put("originalURL", originalURL);
        return res;
    }

    private static boolean isFileAllowed(String fileName) {
        for (String ext : IMAGE_FILE_EXTD) {
            if (ext.equals(fileName)) {
                return true;
            }
        }
        return false;
    }

    private static String[] IMAGE_FILE_EXTD = new String[]{"png", "bmp", "jpg", "jpeg", "pdf"};

}
