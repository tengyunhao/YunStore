package com.yunstore.entity;

public class TeacherStorageType {
    private String id;

    private String teacher;

    private String filetype;

    private Integer size;

    private Integer showtype;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher == null ? null : teacher.trim();
    }

    public String getFiletype() {
        return filetype;
    }

    public void setFiletype(String filetype) {
        this.filetype = filetype == null ? null : filetype.trim();
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Integer getShowtype() {
        return showtype;
    }

    public void setShowtype(Integer showtype) {
        this.showtype = showtype;
    }
}