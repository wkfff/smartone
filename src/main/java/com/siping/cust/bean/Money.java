package com.siping.cust.bean;

import com.siping.productStorage.bean.SYCode;

public class Money {
    private double amount;
    private SYCode unit;

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public SYCode getUnit() {
        return unit;
    }

    public void setUnit(SYCode unit) {
        this.unit = unit;
    }
}
