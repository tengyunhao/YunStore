package com.yunstore.common;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

import java.io.IOException;

public class ResponseData {

    // 响应业务状态
    private Integer status;

    // 响应消息
    private String msg;
    
    private int code;
    
    private int count;

    // 响应中的数据
    private Object data;

    public ResponseData() {

    }
    
    public ResponseData(Integer status, String msg, Object data) {
        this.status = status;
        this.msg = msg;
        this.data = data;
        this.count = 10000;
    }

    public ResponseData(Object data) {
        this.status = 200;
        this.msg = "OK";
        this.data = data;
        this.count = 10000;
    }
    
    public static ResponseData build(Integer status, String msg, Object data) {
        return new ResponseData(status, msg, data);
    }

    public static ResponseData ok(Object data) {
        return new ResponseData(data);
    }

    public static ResponseData ok() {
        return new ResponseData(null);
    }

    public static ResponseData build(Integer status, String msg) {
        return new ResponseData(status, msg, null);
    }

    public Boolean isOK() {
        return this.status == 200;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
    
    public int getCode() {
		return code;
	}
    
    public void setCode(int code) {
		this.code = code;
	}
    
    public int getCount() {
		return count;
	}
    
    public void setCount(int count) {
		this.count = count;
	}

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

}
