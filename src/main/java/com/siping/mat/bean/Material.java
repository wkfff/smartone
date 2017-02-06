package com.siping.mat.bean;

import com.siping.doc.bean.BusinessData;

public class Material extends BusinessData {
    private String bpName;
    private String oldName;
    private Double length;
    private Double width;
    private Double height;
    private Double roughWeight;
    private Double netWeight;
    private String photoPath;
    private Unit unit;
    private Unit weightUnit;
    private Unit lengthUnit;
    private Boolean separated = false;

    public Unit getUnit() {
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }

    public String getBpName() {
        return bpName;
    }

    public void setBpName(String bpName) {
        this.bpName = bpName;
    }

    public String getOldName() {
        return oldName;
    }

    public void setOldName(String oldName) {
        this.oldName = oldName;
    }

    public Double getLength() {
        return length;
    }

    public void setLength(Double length) {
        this.length = length;
    }

    public Double getWidth() {
        return width;
    }

    public void setWidth(Double width) {
        this.width = width;
    }

    public Double getHeight() {
        return height;
    }

    public void setHeight(Double height) {
        this.height = height;
    }

    public Double getRoughWeight() {
        return roughWeight;
    }

    public void setRoughWeight(Double roughtWeight) {
        this.roughWeight = roughtWeight;
    }

    public Double getNetWeight() {
        return netWeight;
    }

    public void setNetWeight(Double netWeight) {
        this.netWeight = netWeight;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }

    public Unit getWeightUnit() {
        return weightUnit;
    }

    public void setWeightUnit(Unit weightUnit) {
        this.weightUnit = weightUnit;
    }

    public Unit getLengthUnit() {
        return lengthUnit;
    }

    public void setLengthUnit(Unit lengthUnit) {
        this.lengthUnit = lengthUnit;
    }

    public Boolean getSeparated() {
        return separated;
    }

    public void setSeparated(Boolean separated) {
        this.separated = separated;
    }

}
