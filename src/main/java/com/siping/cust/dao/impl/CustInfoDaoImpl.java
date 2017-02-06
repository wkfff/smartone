package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.cust.bean.Customer;
import com.siping.cust.dao.CustInfoDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CustInfoDaoImpl extends SqlMapClientSupport implements CustInfoDao {

    public static final String GET_CUSTOMER_LIST = "cust.custInfo.getCustomerList";
    public static final String GET_CUSTOMER_LIST_CNT = "cust.custInfo.getCustomerListCnt";
    public static final String GET_CUSTOMER_DETAIL = "cust.custInfo.getCustomerDetail";
    public static final String GET_ALL_CUSTOMERS_LIST = "cust.custInfo.getAllCustomersList";
    public static final String GET_ALL_CUSTOMERS_LIST_USING_BEAN_MAP = "cust.custInfo.getAllCustomersListUsingBeanMap";

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getCustomerList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList(GET_CUSTOMER_LIST, object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List getCustomerList(Object object, int page, int pagesize) {
        List list = new ArrayList();
        try {
            list = this.queryForList(GET_CUSTOMER_LIST, object, page, pagesize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getCustomerListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject(GET_CUSTOMER_LIST_CNT, object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public Customer getCustomerDetail(Object object) {
        Customer customer = null;
        try {
            customer = (Customer) this.queryForObject(GET_CUSTOMER_DETAIL, object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    @Override
    public List getAllCustomerList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList(GET_ALL_CUSTOMERS_LIST, object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List getAllCustomerList(Object object, int page, int pagesize) {
        List list = new ArrayList();
        try {
            list = this.queryForList(GET_ALL_CUSTOMERS_LIST, object, page, pagesize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Customer> getAllCustomerListUsingBeanMap(Object obj) {
        List list = null;
        try {
            list = this.queryForList(GET_ALL_CUSTOMERS_LIST_USING_BEAN_MAP, obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
