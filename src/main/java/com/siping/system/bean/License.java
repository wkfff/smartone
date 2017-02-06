package com.siping.system.bean;

import java.io.Serializable;
import java.util.Date;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.siping.web.utility.CustomDateSerializer;

public class License implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = -2034432429142674566L;

    private String licenseId;                                               /*license ID*/
    private String licenseKey;                                              /*license key值*/
    private Integer activateType;                                           /*激活类型，0本地，1在线*/
    private String days;                                                    /*有效时间长度*/
    @JsonSerialize(using = CustomDateSerializer.class)
    private Date startDate;                                                 /*激活日期*/
    @JsonSerialize(using = CustomDateSerializer.class)
    private Date endDate;                                                   /*激活结束日期*/
    private String startDateStr;
    private String endDateStr;
    private String encodeStartDate;                                         /*编码后开始日期*/
    private String encodeEndDate;                                           /*编号后结束日期*/
    private String useType;                                                 /*使用类型，试用，正式*/
    private Integer activity;                                               /*删除标识*/
    private Integer status;                                                 /*是否有效状态*/
    private String custId;                                                  /*客户ID*/
    private String custName;                                                
    private String macAddr;                                                 /*物理地址*/
    
    public String getLicenseId() {
        return licenseId;
    }
    public void setLicenseId(String licenseId) {
        this.licenseId = licenseId;
    }
    public String getLicenseKey() {
        return licenseKey;
    }
    public void setLicenseKey(String licenseKey) {
        this.licenseKey = licenseKey;
    }
    public Integer getActivateType() {
        return activateType;
    }
    public void setActivateType(Integer activateType) {
        this.activateType = activateType;
    }
    public String getUseType() {
        return useType;
    }
    public void setUseType(String useType) {
        this.useType = useType;
    }
    public Integer getActivity() {
        return activity;
    }
    public void setActivity(Integer activity) {
        this.activity = activity;
    }
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getEncodeStartDate() {
        return encodeStartDate;
    }
    public void setEncodeStartDate(String encodeStartDate) {
        this.encodeStartDate = encodeStartDate;
    }
    public String getEncodeEndDate() {
        return encodeEndDate;
    }
    public void setEncodeEndDate(String encodeEndDate) {
        this.encodeEndDate = encodeEndDate;
    }
    public String getDays() {
        return days;
    }
    public void setDays(String days) {
        this.days = days;
    }
    public Date getStartDate() {
        return startDate;
    }
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    public Date getEndDate() {
        return endDate;
    }
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    public String getStartDateStr() {
        return startDateStr;
    }
    public void setStartDateStr(String startDateStr) {
        this.startDateStr = startDateStr;
    }
    public String getEndDateStr() {
        return endDateStr;
    }
    public void setEndDateStr(String endDateStr) {
        this.endDateStr = endDateStr;
    }
    public String getCustId() {
        return custId;
    }
    public void setCustId(String custId) {
        this.custId = custId;
    }
    public String getCustName() {
        return custName;
    }
    public void setCustName(String custName) {
        this.custName = custName;
    }
    public String getMacAddr() {
        return macAddr;
    }
    public void setMacAddr(String macAddr) {
        this.macAddr = macAddr;
    }
}
