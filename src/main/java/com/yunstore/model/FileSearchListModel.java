package com.yunstore.model;

import java.util.List;

public class FileSearchListModel {

    private List<FileSearchModel> list;

    private int length;

    public List<FileSearchModel> getList() {
        return list;
    }

    public void setList(List<FileSearchModel> list) {
        this.list = list;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }
}
