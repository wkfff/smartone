package com.siping.cust.bean;

import com.siping.productStorage.bean.Company;
import com.siping.productStorage.bean.SYCode;

public class Contact {
    private Customer customer;
    private String contactId;
    private String contactName;
    private SYCode contactType;
    private Address address;
    private String telePhone;
    private String mobilePhone;
    private String email;
    private String fax;
    private Company company;

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer cusomer) {
        this.customer = cusomer;
    }

    public String getContactId() {
        return contactId;
    }

    public void setContactId(String contactId) {
        this.contactId = contactId;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public SYCode getContactType() {
        return contactType;
    }

    public void setContactType(SYCode contactType) {
        this.contactType = contactType;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
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

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }
}
