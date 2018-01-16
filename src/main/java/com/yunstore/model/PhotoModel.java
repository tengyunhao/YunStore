package com.yunstore.model;

public class PhotoModel {

    // 图片id
    private Integer pid;
    // 图片名
    private String alt;
    // 原图地址
    private String src;
    // 缩略图地址
    private String thumb;

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getAlt() {
        return alt;
    }

    public void setAlt(String alt) {
        this.alt = alt;
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public String getThumb() {
        return thumb;
    }

    public void setThumb(String thumb) {
        this.thumb = thumb;
    }
}
