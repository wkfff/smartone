package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.cust.bean.Customer;
import com.siping.cust.dao.CustManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CustManageDaoImpl extends SqlMapClientSupport implements CustManageDao {

    @Override
    public Object addCustomer(Object object) throws SQLException {
        return this.insert("cust.custManage.addCustomer", object);
    }

    @Override
    public Object updateCustomer(Object object) throws SQLException {
        return this.update("cust.custManage.updateCustomer", object);
    }

    @Override
    public Customer getCustomerDetail(Object object) {
        Customer customer = null;
        try {
            customer = (Customer) this.queryForObject("cust.custInfo.getCustomerDetailByUpdate", object);
        } catch (SQLException e) {
            logger.error(e.getMessage());
        }
        return customer;
    }

    @Override
    public Object removeCustomer(Object object) throws SQLException {
        return this.update("cust.custManage.removeCustomer", object);
    }

    @Override
    public int checkCustomerID(Object object) throws SQLException {
        return (Integer) (this.queryForObject("cust.custManage.checkCustomerID", object));
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void changeCustomerEMPID(List object) throws SQLException {
        this.updateForList("cust.custManage.changeCustomerEMPID", object);
    }

    @Override
    public int isExsitCustomer(Object object) {
        int i = 0;
        try {
            i = (Integer) this.queryForObject("cust.custManage.isExsitCustomer", object);
        } catch (SQLException e) {
            logger.error(e.getMessage());
        }
        return i;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int checkCustID(Map map) throws Exception {
        return Integer.parseInt(this.queryForObject("cust.custManage.checkCustID", map).toString());
    }

    @Override
    public Customer getCustomerNameById(Object object) throws SQLException {
        return (Customer) this.queryForObject("cust.custManage.getCustomerName", object);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List<HashMap> getCustTitles(Map tmpParamMap) {
        List resultList = null;
        try {
            resultList = this.queryForList("cust.custManage.queryCustColumnTitles", tmpParamMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String[] getCustOptions(Map optionParamMap) {
        List list = null;
        try {
            list = this.queryForList("cust.custManage.queryCustCellOptions", optionParamMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return this.list2StringArray(list);
    }

    @SuppressWarnings("rawtypes")
    public String[] list2StringArray(List list) {
        if (list == null || list.size() == 0)
            return null;
        Object[] objects = list.toArray();
        String[] resultArray = new String[list.size()];
        // Cast Object[] to String[]
        for (int i = 0, j = 0; i < objects.length; i++) {
            if (objects[i] != null) {
                resultArray[j] = (String) objects[i];
                j++;
            }
        }
        return resultArray;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void createTempCustomerInfo(Map map) throws Exception {
        this.update("cust.custManage.createTempCustInfo", map);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateTempCustomerTitles(List titleList) throws Exception {
        this.insertForList("cust.custManage.updateTempCustTitles", titleList);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateTempCustomerInfo(List paramList) throws Exception {
        this.updateForList("cust.custManage.updateTempCustInfo", paramList);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getCustColumnList() throws Exception {
        return this.queryForList("cust.custManage.getCustColumnList");
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getCustTmpInfoList() throws Exception {
        return this.queryForList("cust.custManage.getCustTmpInfoList");
    }

    @Override
    public void modifyCustTmpTable() throws Exception {
        this.update("cust.custManage.modifyCustTmpTable");
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getCustInsertList(Map paramMap) throws Exception {
        return this.queryForList("cust.custManage.getCustInsertList", paramMap);
    }

    @Override
    public void insertCustomer(List<LinkedHashMap<String, Object>> requestListData) throws Exception {
        this.insertForList("cust.custManage.insertCustomer", requestListData);
    }
}
