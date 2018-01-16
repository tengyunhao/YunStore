package com.yunstore.model;

import java.text.DecimalFormat;

public class StorageTypeModel {

    private String type;

    private String size;

    private Integer length;

    private String used;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    public String getUsed() {
        return used;
    }

    public void setUsed(int length, int total) {

        DecimalFormat df = new DecimalFormat("######0.00");
        double value = ((double) length / (double) total)*100;
        this.used = df.format(value);
    }
}
