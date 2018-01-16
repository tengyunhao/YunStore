package com.yunstore.common;

import java.io.*;
import java.net.URI;
import java.util.Arrays;
import java.util.List;
import java.util.ListIterator;
import java.util.logging.Filter;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;


public class OperatingFiles {

    public static void main(String[] args) {
//        try {
//            FileInputStream inputStream = new FileInputStream(new File("/Users/tengyunhao/Desktop/常用命令.txt"));
//
//            // 获得FileSystem对象，指定使用root用户上传
//            FileSystem fileSystem = FileSystem.get(new URI("hdfs://localhost:9000"), new Configuration(), "localhost");
//            // 调用create方法指定文件上传，参数HDFS上传路径
//            OutputStream out = fileSystem.create(new Path("/tengyunhao"));
//            // 使用Hadoop提供的IOUtils，将in的内容copy到out，设置buffSize大小，是否关闭流设置true
//            IOUtils.copyBytes(inputStream, out, 4096, true);
//        } catch (Exception e1) {
//            e1.printStackTrace();
//        }
        printN(5);
    }

    public static void printN(int n) {
        if(n-1 > 0) {
            printN(n-1);
        }
        System.out.println(n);
    }

}