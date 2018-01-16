package com.yunstore.model;

import java.util.List;

public class PhotoAlbumModel {

    // 相册id
    private Integer id;
    // 相册标题
    private String title;
    // 初始显示的图片序号，默认0
    private Integer start;
    // 相册包含的图
    private List<PhotoModel> data;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public List<PhotoModel> getData() {
        return data;
    }

    public void setData(List<PhotoModel> data) {
        this.data = data;
    }
}
