package com.yunstore.utils;

import org.apache.commons.lang.StringUtils;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.*;
import org.apache.hadoop.io.IOUtils;

import java.io.*;

public class HDFSUtil {

    private static HDFSUtil instance = null;

    private FileSystem fs;

    private Configuration conf;

    private HDFSUtil() {
        //设置hdfs的配置文件中配置节
        conf=new Configuration();
        //为什么去掉下面的两行就不行
        conf.set("fs.defaultFS","hdfs://47.104.61.134:9000" );
        conf.set("fs.hdfs.impl", "org.apache.hadoop.hdfs.DistributedFileSystem");
        //1.利用设置的配置文件来实例化FileSystem
        try {
            fs = FileSystem.get(conf);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static HDFSUtil getInstance() {
        if(instance == null) {
            instance = new HDFSUtil();
        }
        return instance;
    }

    public static void main(String[] args) throws IOException {
        HDFSUtil.getInstance().uploadFile("/Users/tengyunhao/Desktop/屏幕快照 2018-01-12 上午10.30.35.png","/");
    }

    public void mkdir(String path) throws IOException {

        Path srcPath =  new Path(path);
        //调用mkdir（）创建目录，（可以一次性创建，以及不存在的父目录）
        boolean flag = fs.mkdirs(srcPath);
        if(flag) {
            System.out.println("create dir ok!");
        }else {
            System.out.println("create dir failure");
        }

        //关闭文件系统
        fs.close();
    }

    public void deleteFile(String filePath) throws IOException {

        Path path = new Path(filePath);
        //调用deleteOnExit(）
        boolean flag = fs.deleteOnExit(path);
        //  fs.delete(path);
        if(flag) {
            System.out.println("delete ok!");
        }else {
            System.out.println("delete failure");
        }
        //关闭文件系统
        fs.close();
    }

    /**创建文件**/
    public void createFile(String dst , byte[] contents) throws IOException {
        //目标路径
        Path dstPath = new Path(dst);
        //打开一个输出流
        FSDataOutputStream outputStream = fs.create(dstPath);
        outputStream.write(contents);

        //关闭文件系统
        outputStream.close();
        fs.close();
        System.out.println("文件创建成功！");

    }

    public void uploadFile(String src, String dst) throws IOException{

        Path srcPath = new Path(src); //原路径
        Path dstPath = new Path(dst); //目标路径
        //调用文件系统的文件复制函数,前面参数是指是否删除原文件，true为删除，默认为false
        fs.copyFromLocalFile(false,srcPath, dstPath);

        //打印文件路径
        System.out.println("Upload to "+conf.get("fs.default.name"));
        System.out.println("------------list files------------"+"\n");
        FileStatus [] fileStatus = fs.listStatus(dstPath);
        for (FileStatus file : fileStatus) {
            System.out.println(file.getPath());
        }

        //关闭文件系统
        fs.close();
    }

    public void listFile(String path, FileSystem fs) {
        //获取文件或目录状态
        FileStatus[] fileStatus = new FileStatus[0];
        try {
            fileStatus = fs.listStatus(new Path(path));
        } catch (IOException e) {
            e.printStackTrace();
        }
        //打印文件的路径
        for (FileStatus file : fileStatus) {
            System.out.println(file.getPath());
        }
        //关闭文件系统
        try {
            fs.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**文件重命名**/
    public void renameFile(String oldName,String newName) throws IOException {
        Path oldPath = new Path(oldName);
        Path newPath = new Path(newName);

        boolean flag = fs.rename(oldPath, newPath);
        if(flag) {
            System.out.println("rename ok!");
        }else {
            System.out.println("rename failure");
        }

        //关闭文件系统
        fs.close();
    }

    public void downloadFile(String dest, File local) throws IOException {
        FSDataInputStream fsdi = fs.open(new Path("hdfs://47.104.61.134:9000"+dest));
        OutputStream outputStream = new FileOutputStream(local);
        IOUtils.copyBytes(fsdi, outputStream, 4096, true);
    }

    public void readFile(String uri) throws IOException {
        InputStream in = null;
        try {
            in = fs.open(new Path(uri));
            //复制到标准输出流
            IOUtils.copyBytes(in, System.out, 4096,false);
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            IOUtils.closeStream(in);
        }
    }

    //判断目录是否存在
    public boolean existDir(String filePath,boolean create) {
        boolean flag = false;
        //判断是否存在
        if(StringUtils.isEmpty(filePath)) {
            return flag;
        }

        Path path = new Path(filePath);
        try {

            //或者create为true
            if(create) {
                //如果文件不存在
                if(!fs.exists(path)) {
                    fs.mkdirs(path);
                }
            }
            //判断是否为目录
            if(fs.isDirectory(path)) {
                flag = true;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return flag;
    }

    /**添加到文件的末尾(src为本地地址，dst为hdfs文件地址)
     * @throws IOException */
    public void appendFile(String src,String dst) throws IOException {

        Path dstPath = new Path(dst);
        //创建需要写入的文件流
        InputStream in = new BufferedInputStream(new FileInputStream(src));

        //文件输出流写入
        FSDataOutputStream out = fs.append(dstPath);
        IOUtils.copyBytes(in, out, 4096,true);

        fs.close();
    }

}
