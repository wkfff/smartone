package com.siping.cust.service;

import com.siping.cust.bean.Customer;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

public interface CustInfoSer {
    @SuppressWarnings({ "rawtypes" })
    public List getCustomerList(HttpServletRequest request);

    public int getCustomerListCnt(HttpServletRequest request);

    public Object getCustomerDetail(HttpServletRequest request);

    List getAllCustomerList(HttpServletRequest request);

    List<Customer> getAllCustomerListUsingBeanMap(HttpServletRequest request);
}
