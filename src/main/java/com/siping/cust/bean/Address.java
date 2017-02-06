package com.siping.cust.bean;

import com.google.common.base.Joiner;
import com.siping.productStorage.bean.SYCode;

public class Address {
    private SYCode province;
    private SYCode city;
    private SYCode area;
    private String address;
    private String wholeAddress;

    public SYCode getProvince() {
        return province;
    }

    public void setProvince(SYCode province) {
        this.province = province;
    }

    public SYCode getCity() {
        return city;
    }

    public void setCity(SYCode city) {
        this.city = city;
    }

    public SYCode getArea() {
        return area;
    }

    public void setArea(SYCode area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getWholeAddress() {
        if (wholeAddress == null)
            return Joiner.on("").skipNulls().join(province == null ? "" : province.getCodeName() , city == null ? "" : city.getCodeName() , area == null ? "" : area.getCodeName(), this.address);
        else
            return this.wholeAddress;

    }

    public void setWholeAddress(String wholeAddress) {
        this.wholeAddress = wholeAddress;
    }
    
}
