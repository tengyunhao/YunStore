package com.yunstore.model;

import java.util.List;

public class StorageModel {

    private String total;

    private String surplus;

    private Integer percent;

    private List<StorageTypeModel> list;

    private StoragePieModel pie;

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getSurplus() {
        return surplus;
    }

    public void setSurplus(String surplus) {
        this.surplus = surplus;
    }

    public Integer getPercent() {
        return percent;
    }

    public void setPercent(Integer percent) {
        this.percent = percent;
    }

    public List<StorageTypeModel> getList() {
        return list;
    }

    public void setList(List<StorageTypeModel> list) {
        this.list = list;
    }

    public StoragePieModel getPie() {
        return pie;
    }

    public void setPie(StoragePieModel pie) {
        this.pie = pie;
    }
}
