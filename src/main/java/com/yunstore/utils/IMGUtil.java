package com.yunstore.utils;

import sun.misc.BASE64Decoder;

import java.io.FileOutputStream;
import java.io.OutputStream;

public class IMGUtil {

    public static boolean generateImage(String imgStr, String path) {

        if (imgStr == null) {
            return false;
        }

        BASE64Decoder decoder = new BASE64Decoder();

        try {
            // 解密
            byte[] b = decoder.decodeBuffer(imgStr);
            // 处理数据
            for (int i = 0; i < b.length ; i++) {
                if(b[i] < 0) {
                    b[i] += 256;
                }
            }

            OutputStream outputStream = new FileOutputStream(path);
            outputStream.write(b);
            outputStream.flush();
            outputStream.close();
            return true;

        } catch (Exception e) {
            System.out.println(e);
        }

        return false;
    }

}
