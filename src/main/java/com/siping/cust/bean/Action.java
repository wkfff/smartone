package com.siping.cust.bean;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.siping.productStorage.bean.SYCode;
import com.siping.web.utility.BeanDateSerializer;

/**  
 * @Description:
 * @author yinglai.yuan 
 * @date 2014-4-21 下午3:48:13
 * @version V2.0
 * © copyright -Made by SiPingSoft. 
 */
public class Action {
    private String custActionNo;//活动NO
    private String custId;      //客户ID
    private String empId;       //员工ID
    private SYCode actionWayCode;//活动方式
    private String actionContent;//活动内容
    private SYCode actionState;  //行为状态
    @JsonSerialize(using = BeanDateSerializer.class)
    private Date createDate;//创建日期
    @JsonSerialize(using = BeanDateSerializer.class)
    private Date actionTime;//活动时间
    private SYCode actionType;//活动类型
    private SYCode purchase;  //购买意向
    private String contact;      //联系人
    private String mobilePhone;  //联系方式
    private Customer customer;   //联系人
    public String getCustActionNo() {
        return custActionNo;
    }
    public void setCustActionNo(String custActionNo) {
        this.custActionNo = custActionNo;
    }
    public String getCustId() {
        return custId;
    }
    public void setCustId(String custId) {
        this.custId = custId;
    }
    public String getEmpId() {
        return empId;
    }
    public void setEmpId(String empId) {
        this.empId = empId;
    }
    public SYCode getActionWayCode() {
        return actionWayCode;
    }
    public void setActionWayCode(SYCode actionWayCode) {
        this.actionWayCode = actionWayCode;
    }
    public String getActionContent() {
        return actionContent;
    }
    public void setActionContent(String actionContent) {
        this.actionContent = actionContent;
    }
    public SYCode getActionState() {
        return actionState;
    }
    public void setActionState(SYCode actionState) {
        this.actionState = actionState;
    }
    public Date getCreateDate() {
        return createDate;
    }
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    public SYCode getActionType() {
        return actionType;
    }
    public void setActionType(SYCode actionType) {
        this.actionType = actionType;
    }
    public Date getActionTime() {
        return actionTime;
    }
    public void setActionTime(Date actionTime) {
        this.actionTime = actionTime;
    }
    public SYCode getPurchase() {
        return purchase;
    }
    public void setPurchase(SYCode purchase) {
        this.purchase = purchase;
    }
    public String getContact() {
        return contact;
    }
    public void setContact(String contact) {
        this.contact = contact;
    }
    public String getMobilePhone() {
        return mobilePhone;
    }
    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }
    public Customer getCustomer() {
        return customer;
    }
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}
