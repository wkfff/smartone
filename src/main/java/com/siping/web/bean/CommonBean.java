package com.siping.web.bean;

import java.io.Serializable;

public class CommonBean implements Serializable{

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String createDate;
    private String createdBy;
    private String updateDate;
    private String updatedBy;
    private Integer orderNo;
    private Integer activity;
    private String cpnyId;
    public String getCreateDate() {
        return createDate;
    }
    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
    public String getCreatedBy() {
        return createdBy;
    }
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    public String getUpdateDate() {
        return updateDate;
    }
    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate;
    }
    public String getUpdatedBy() {
        return updatedBy;
    }
    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }
    public Integer getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }
    public Integer getActivity() {
        return activity;
    }
    public void setActivity(Integer activity) {
        this.activity = activity;
    }
    public String getCpnyId() {
        return cpnyId;
    }
    public void setCpnyId(String cpnyId) {
        this.cpnyId = cpnyId;
    }
}
