package com.siping.cust.bean;

import java.util.List;

import com.siping.productStorage.bean.Company;
import com.siping.productStorage.bean.Employee;
import com.siping.productStorage.bean.SYCode;

public class Customer {
    private String customerNo;
    private String customerId;
    private String customerName;
    private SYCode customerType;
    private SYCode custSalesMode;
    private SYCode customerStatus;
    private SYCode customerLevel;
    private String description;
    private String remark;

    private Employee owner;
    private Company company;

    public SYCode getCustSalesMode() {
        return custSalesMode;
    }

    public void setCustSalesMode(SYCode custSalesMode) {
        this.custSalesMode = custSalesMode;
    }

    private String bankName;
    private String bankCode;
    private String taxPayerCode;

    private Money credit;

    private Address registerAddress;
    private Address officeAddress;

    private String telePhone;
    private String mobilePhone;
    private String fax;
    private String email;
    private String taobaoId;
    public String getTaobaoId() {
        return taobaoId;
    }

    public void setTaobaoId(String taobaoId) {
        this.taobaoId = taobaoId;
    }

    private Contact contact;
    private Receiver receiver;
    private List<Contact> contacts;
    private List<Receiver> receivers;
    private List<Action> actions;
    public List<Action> getActions() {
        return actions;
    }

    public void setActions(List<Action> actions) {
        this.actions = actions;
    }


    public String getCustomerNo() {
        return customerNo;
    }

    public List<Contact> getContacts() {
        return contacts;
    }

    public void setContacts(List<Contact> contacts) {
        this.contacts = contacts;
    }

    public Contact getContact() {
        return contact;
    }

    public void setContact(Contact contact) {
        this.contact = contact;
    }

    public Receiver getReceiver() {
        return receiver;
    }

    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }

    

    public void setCustomerNo(String customerNo) {
        if (this.customerNo == null || this.customerNo == "")
            this.customerNo = customerNo;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        if (this.customerId == null || this.customerId == "")
            this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getTaxPayerCode() {
        return taxPayerCode;
    }

    public void setTaxPayerCode(String taxPayerCode) {
        this.taxPayerCode = taxPayerCode;
    }

    public SYCode getCustomerType() {
        return customerType;
    }

    public void setCustomerType(SYCode customerType) {
        this.customerType = customerType;
    }

    public SYCode getCustomerStatus() {
        return customerStatus;
    }

    public void setCustomerStatus(SYCode customerStatus) {
        this.customerStatus = customerStatus;
    }

    public Address getOfficeAddress() {
        return officeAddress;
    }

    public void setOfficeAddress(Address officeAddress) {
        this.officeAddress = officeAddress;
    }

    public Employee getOwner() {
        return owner;
    }

    public void setOwner(Employee owner) {
        this.owner = owner;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getTelePhone() {
        return telePhone;
    }

    public void setTelePhone(String telePhone) {
        this.telePhone = telePhone;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public SYCode getCustomerLevel() {
        return customerLevel;
    }

    public void setCustomerLevel(SYCode customerLevel) {
        this.customerLevel = customerLevel;
    }

    public Money getCredit() {
        return credit;
    }

    public void setCredit(Money credit) {
        this.credit = credit;
    }

    public Address getRegisterAddress() {
        return registerAddress;
    }

    public void setRegisterAddress(Address registerAddress) {
        this.registerAddress = registerAddress;
    }

   

  

    public List<Receiver> getReceivers() {
        return receivers;
    }

    public void setReceivers(List<Receiver> receivers) {
        this.receivers = receivers;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }
}
