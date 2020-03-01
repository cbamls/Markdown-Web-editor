package com.aiq.editor.service;

import com.aiq.editor.auth.JwtUtil;
import com.aiq.editor.common.Constants;
import com.alibaba.fastjson.JSONObject;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Service
public class QiNiuService {

    private static final Logger logger = LoggerFactory.getLogger(QiNiuService.class);

    // 设置好账号的ACCESS_KEY和SECRET_KEY
    String ACCESS_KEY = "mwFCI8T3obEgALQL4QIxcup_-iiCY11kfax1Bhh4";
    String SECRET_KEY = "tY6yFwXW48ZuqMyb8NeKlvvl9gQ_AMv92c-k713p";
    // 要上传的空间
    String bucketname = "spider";

    // 密钥配置
    Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
    // 构造一个带指定Zone对象的配置类,不同的七云牛存储区域调用不同的zone
    Configuration cfg = new Configuration(Zone.zone0());
    // ...其他参数参考类注释
    UploadManager uploadManager = new UploadManager(cfg);

    // 测试域名，只有30天有效期
    private static String QINIU_IMAGE_DOMAIN = "http://rna.6aiq.com/";

    // 简单上传，使用默认策略，只需要设置上传的空间名就可以了
    public String getUpToken() {
        return auth.uploadToken(bucketname);
    }

    public String saveImage(MultipartFile file, String token) {
        try {
            if (file.getBytes().length > Constants.MAX_FILE_BYTES) {
                logger.error("文件长度太大，上传失败");
                return null;
            }
            int dotPos = file.getOriginalFilename().lastIndexOf(".");
            if (dotPos < 0) {
                return null;
            }
            String fileExt = file.getOriginalFilename().substring(dotPos + 1).toLowerCase();
            // 判断是否是合法的文件后缀
            if (!isFileAllowed(fileExt)) {
                return null;
            }

            String fileName = "image-" + UUID.randomUUID().toString().replaceAll("-", "") + "." + fileExt;
            boolean admin = JwtUtil.checkLogin(token) && JwtUtil.getUsername(token).equals("cbam");

            Response res;
            if (admin) {
                res = uploadManager.put(file.getBytes(), fileName, auth.uploadToken("aiqimg"));
            } else {
                res = uploadManager.put(file.getBytes(), fileName, getUpToken());
            }
            // 打印返回的信息
            if (res.isOK() && res.isJson()) {

                String realPath;
                if (admin) {
                    realPath = "http://img.6aiq.com/" + JSONObject.parseObject(res.bodyString()).get("key");
                } else {
                    realPath = QINIU_IMAGE_DOMAIN + JSONObject.parseObject(res.bodyString()).get("key");
                }
                // 返回这张存储照片的地址
                return realPath;
            } else {
                logger.error("七牛异常:" + res.bodyString());
                return null;
            }
        } catch (Exception e) {
            // 请求失败时打印的异常的信息
            logger.error("七牛异常:" + e);
            return null;
        }
    }


    public static boolean isFileAllowed(String fileName) {
        for (String ext : IMAGE_FILE_EXTD) {
            if (ext.equals(fileName)) {
                return true;
            }
        }
        return false;
    }

    public static String[] IMAGE_FILE_EXTD = new String[]{"png", "bmp", "jpg", "jpeg", "pdf", "gif", "wav"};

}
