package com.siping.hrm.bean;

import java.math.BigDecimal;

import com.siping.web.bean.CommonBean;

public class ApplyCost extends CommonBean{

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private Integer expNo;
    private String empid;
    private String expTypeCode;
    private String expReason;
    private Integer affirmFlag;
    private BigDecimal moneyAmount;
    private String processId;

    public Integer getExpNo() {
        return expNo;
    }
    public void setExpNo(Integer expNo) {
        this.expNo = expNo;
    }
    public String getEmpid() {
        return empid;
    }
    public void setEmpid(String empid) {
        this.empid = empid;
    }
    public String getExpTypeCode() {
        return expTypeCode;
    }
    public void setExpTypeCode(String expTypeCode) {
        this.expTypeCode = expTypeCode;
    }
    public String getExpReason() {
        return expReason;
    }
    public void setExpReason(String expReason) {
        this.expReason = expReason;
    }
    public Integer getAffirmFlag() {
        return affirmFlag;
    }
    public void setAffirmFlag(Integer affirmFlag) {
        this.affirmFlag = affirmFlag;
    }
    public BigDecimal getMoneyAmount() {
        return moneyAmount;
    }
    public void setMoneyAmount(BigDecimal moneyAmount) {
        this.moneyAmount = moneyAmount;
    }
    public String getProcessId() {
        return processId;
    }
    public void setProcessId(String processId) {
        this.processId = processId;
    }
}
