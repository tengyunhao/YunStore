package com.yunstore.model;

import org.omg.PortableInterceptor.INACTIVE;

import java.util.HashMap;
import java.util.Map;

public class StoragePieModel {

    private String labels;

    private String datasets;
    private String[] color = {"#6c70ed","#a3a70b","#32c2ed","#0083a7","#a7575d","#a7a679","#a7a679"};

    public StoragePieModel(Map<String, Integer> map) {

        StringBuffer label = new StringBuffer();
        StringBuffer data = new StringBuffer();
        StringBuffer colors = new StringBuffer();
        label.append("[");
        data.append("[");
        colors.append("[");
        int i = 0;
        for (String key : map.keySet()) {
            if(i != 0) {
                label.append(",");
                data.append(",");
                colors.append(",");
            }
            label.append("\""+key+"\"");
            data.append(map.get(key));
            colors.append("\""+color[i]+"\"");
            i++;
        }
        label.append("]");
        data.append("]");
        colors.append("]");
        this.labels = label.toString();
        this.datasets = "[{data: "+data+",backgroundColor: "+colors+",hoverBackgroundColor: "+colors+"}]";
    }

    public String getLabels() {
        return labels;
    }

    public String getDatasets() {
        return datasets;
    }

}
