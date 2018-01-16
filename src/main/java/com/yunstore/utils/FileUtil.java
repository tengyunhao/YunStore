package com.yunstore.utils;

import java.io.File;
import java.text.DecimalFormat;



public class FileUtil {

    private static String[] units = {"B","KB","MB","GB","TB"};

    public static String getSize(String filePath) {
        File file = new File(filePath);
        double length = file.length();
        DecimalFormat df = new DecimalFormat("######0.00");
        for (int i = 0; i < units.length; i++) {
            if(length/1024 > 1) {
                length /= 1024;
                continue;
            } else {
                return df.format(length)+" "+units[i];
            }
        }
        return "未知大小";
    }

    public static String getSizeOfUnit(double size, FizeSize unit) {
        DecimalFormat df = new DecimalFormat("######0.00");
        int n = 0;
        switch (unit) {
            case B: n = 1; break;
            case KB: n = 2; break;
            case MB: n = 3; break;
            case GB: n = 4; break;
            case TB: n = 5; break;
        }
        for (int i = 0; i < units.length; i++) {
            if(i < n-1) {
                continue;
            }
            if(size/1024 > 1) {
                size /= 1024;
                continue;
            } else {
                return df.format(size)+" "+units[i];
            }
        }
        return "未知大小";
    }

    public enum FizeSize {
        B,
        KB,
        MB,
        GB,
        TB
    }
}
