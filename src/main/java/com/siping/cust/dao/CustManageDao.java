package com.siping.cust.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.siping.cust.bean.Customer;

public interface CustManageDao {
    public Object addCustomer(Object object) throws SQLException;

    public Object updateCustomer(Object object) throws SQLException;

    public Customer getCustomerDetail(Object object);

    public Object removeCustomer(Object object) throws SQLException;

    public int checkCustomerID(Object object) throws SQLException;

    @SuppressWarnings("rawtypes")
    public void changeCustomerEMPID(List object) throws SQLException;

    public int isExsitCustomer(Object object);

    @SuppressWarnings("rawtypes")
    public int checkCustID(Map map) throws Exception;

    public Customer getCustomerNameById(Object object) throws SQLException;

    @SuppressWarnings("rawtypes")
    public List<HashMap> getCustTitles(Map tmpParamMap);

    @SuppressWarnings("rawtypes")
    public String[] getCustOptions(Map optionParamMap);

    @SuppressWarnings("rawtypes")
    public void createTempCustomerInfo(Map map) throws Exception;

    @SuppressWarnings("rawtypes")
    public void updateTempCustomerTitles(List titleList) throws Exception;

    @SuppressWarnings("rawtypes")
    public void updateTempCustomerInfo(List paramList) throws Exception;

    @SuppressWarnings("rawtypes")
    public List getCustColumnList() throws Exception;

    @SuppressWarnings("rawtypes")
    public List getCustTmpInfoList() throws Exception;

    public void modifyCustTmpTable() throws Exception;

    @SuppressWarnings("rawtypes")
    public List getCustInsertList(Map paramMap) throws Exception;

    public void insertCustomer(List<LinkedHashMap<String, Object>> requestListData) throws Exception;
}
