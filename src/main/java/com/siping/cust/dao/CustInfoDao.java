package com.siping.cust.dao;

import com.siping.cust.bean.Customer;

import java.util.List;

public interface CustInfoDao {
    @SuppressWarnings({"rawtypes"})
    public List getCustomerList(Object object);

    public int getCustomerListCnt(Object object);

    List getCustomerList(Object object, int page, int pagesize);

    public Customer getCustomerDetail(Object object);

    List getAllCustomerList(Object object);

    List getAllCustomerList(Object object, int page, int pagesize);

    List<Customer> getAllCustomerListUsingBeanMap(Object obj);
}
