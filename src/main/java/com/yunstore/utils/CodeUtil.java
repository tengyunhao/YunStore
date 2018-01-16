package com.yunstore.utils;

import java.util.Random;

public class CodeUtil {

    public static String getVerifyCode(){

        int verifySize = 6;
        Random rand = new Random(System.currentTimeMillis());
        StringBuilder verifyCode = new StringBuilder(verifySize);
        for(int i = 0; i < verifySize; i++){
            verifyCode.append(rand.nextInt(10));
        }
        return verifyCode.toString();
    }

    public static void main(String[] args) {
        System.out.println(getVerifyCode());
    }

}
