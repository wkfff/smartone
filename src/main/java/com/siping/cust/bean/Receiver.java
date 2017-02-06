package com.siping.cust.bean;

public class Receiver {
    private Customer customer;
    private String receiverId;
    private String receiverName;
    private String mobilePhone;
    private String telePhone;
    private String email;
    private Address address;

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer cusomer) {
        this.customer = cusomer;
    }

    public String getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(String receiverId) {
        this.receiverId = receiverId;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobile) {
        this.mobilePhone = mobile;
    }

    public String getTelePhone() {
        return telePhone;
    }

    public void setTelePhone(String telePhone) {
        this.telePhone = telePhone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Address getAddress() {
        return this.address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }
}
