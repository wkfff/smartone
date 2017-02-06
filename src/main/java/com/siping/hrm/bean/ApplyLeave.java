package com.siping.hrm.bean;

import com.siping.web.bean.CommonBean;

public class ApplyLeave extends CommonBean{

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private Integer leaveNo;
    private String empid;
    private String leaveTypeCode;
    private String leaveFromTime;
    private String leaveToTime;
    private String leaveReason;
    private String affirmFlag;
    private String leaveRemark;
    private String leaveWaEmpid;
    private String cancelRemark;
    private String conRemark;
    private String processId;

    public Integer getLeaveNo() {
        return leaveNo;
    }
    public void setLeaveNo(Integer leaveNo) {
        this.leaveNo = leaveNo;
    }
    public String getEmpid() {
        return empid;
    }
    public void setEmpid(String empid) {
        this.empid = empid;
    }
    public String getLeaveTypeCode() {
        return leaveTypeCode;
    }
    public void setLeaveTypeCode(String leaveTypeCode) {
        this.leaveTypeCode = leaveTypeCode;
    }
    public String getLeaveReason() {
        return leaveReason;
    }
    public void setLeaveReason(String leaveReason) {
        this.leaveReason = leaveReason;
    }
    public String getAffirmFlag() {
        return affirmFlag;
    }
    public void setAffirmFlag(String affirmFlag) {
        this.affirmFlag = affirmFlag;
    }
    public String getLeaveRemark() {
        return leaveRemark;
    }
    public void setLeaveRemark(String leaveRemark) {
        this.leaveRemark = leaveRemark;
    }
    public String getLeaveWaEmpid() {
        return leaveWaEmpid;
    }
    public void setLeaveWaEmpid(String leaveWaEmpid) {
        this.leaveWaEmpid = leaveWaEmpid;
    }
    public String getCancelRemark() {
        return cancelRemark;
    }
    public void setCancelRemark(String cancelRemark) {
        this.cancelRemark = cancelRemark;
    }
    public String getConRemark() {
        return conRemark;
    }
    public void setConRemark(String conRemark) {
        this.conRemark = conRemark;
    }
    public String getProcessId() {
        return processId;
    }
    public void setProcessId(String processId) {
        this.processId = processId;
    }
    public String getLeaveFromTime() {
        return leaveFromTime;
    }
    public void setLeaveFromTime(String leaveFromTime) {
        this.leaveFromTime = leaveFromTime;
    }
    public String getLeaveToTime() {
        return leaveToTime;
    }
    public void setLeaveToTime(String leaveToTime) {
        this.leaveToTime = leaveToTime;
    }

}
