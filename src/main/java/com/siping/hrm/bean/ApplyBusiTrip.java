package com.siping.hrm.bean;

import com.siping.web.bean.CommonBean;

public class ApplyBusiTrip extends CommonBean{

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private Integer btNo;
    private String empid;
    private String btTypeCode;
    private String btFromTime;
    private String btToTime;
    private String btContent;
    private String btWaEmpid;
    private Integer affirmFlag;
    private String processId;
    private String btCity;
    private String btProvince;

    public Integer getBtNo() {
        return btNo;
    }
    public void setBtNo(Integer btNo) {
        this.btNo = btNo;
    }
    public String getEmpid() {
        return empid;
    }
    public void setEmpid(String empid) {
        this.empid = empid;
    }
    public String getBtTypeCode() {
        return btTypeCode;
    }
    public void setBtTypeCode(String btTypeCode) {
        this.btTypeCode = btTypeCode;
    }
    public String getBtFromTime() {
        return btFromTime;
    }
    public void setBtFromTime(String btFromTime) {
        this.btFromTime = btFromTime;
    }
    public String getBtToTime() {
        return btToTime;
    }
    public void setBtToTime(String btToTime) {
        this.btToTime = btToTime;
    }
    public String getBtContent() {
        return btContent;
    }
    public void setBtContent(String btContent) {
        this.btContent = btContent;
    }
    public String getBtWaEmpid() {
        return btWaEmpid;
    }
    public void setBtWaEmpid(String btWaEmpid) {
        this.btWaEmpid = btWaEmpid;
    }
    public String getProcessId() {
        return processId;
    }
    public void setProcessId(String processId) {
        this.processId = processId;
    }
    public String getBtCity() {
        return btCity;
    }
    public void setBtCity(String btCity) {
        this.btCity = btCity;
    }
    public String getBtProvince() {
        return btProvince;
    }
    public void setBtProvince(String btProvince) {
        this.btProvince = btProvince;
    }
    public Integer getAffirmFlag() {
        return affirmFlag;
    }
    public void setAffirmFlag(Integer affirmFlag) {
        this.affirmFlag = affirmFlag;
    }
}
