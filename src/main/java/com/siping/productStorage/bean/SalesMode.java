package com.siping.productStorage.bean;

public class SalesMode {
    private String salesModeNo;
    private String salesModeId;
    private String salesModeName;
    private String remark;

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getSalesModeId() {
        return salesModeId;
    }

    public void setSalesModeId(String salesModeId) {
        this.salesModeId = salesModeId;
    }

    public String getSalesModeNo() {
        return salesModeNo;
    }

    public void setSalesModeNo(String salesModeNo) {
        this.salesModeNo = salesModeNo;
    }

    public String getSalesModeName() {
        return salesModeName;
    }

    public void setSalesModeName(String salesModeName) {
        this.salesModeName = salesModeName;
    }
}
