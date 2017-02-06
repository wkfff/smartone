package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.cust.dao.SupplierManagerDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SupplierManagerDaoImpl extends SqlMapClientSupport implements SupplierManagerDao {

    private static final String SUCCESS = "Y";

    @Override
    public String addProduct(Object object) {
        String returnString = SUCCESS;
        try {
            this.insert("prostorage.Supplier.addNewSupplier", object);
        } catch (SQLException e) {
            returnString = e.getMessage();
            e.printStackTrace();
        }
        return returnString;
    }

    @Override
    public List getSupplierModelList(Object object, int currentPage, int pageSize) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostorage.Supplier.getSupplierModelList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String deleteSupplierModel(Map map) {
        String resultString = SUCCESS;
        try {
            this.delete("prostorage.Supplier.deleteSupplierModel", map);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String updateSupplierModel(Object object) {
        String resultString = SUCCESS;
        try {
            this.update("prostorage.Supplier.updateSupplierModel", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public int getSupplierModelCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt((this.queryForObject("prostorage.Supplier.getSupplierModelListCnt", object).toString()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public List getSuppliserModelList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostorage.Supplier.getSupplierModelList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Object getSupplierDetatil(Object object) {
        Object obj = null;
        try {
            obj = this.queryForObject("prostorage.Supplier.selectSupplierDetatil", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return obj;
    }

    @Override
    public int getSupplierProductCountCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt((this.queryForObject("prostorage.Supplier.getSupplierProductCountBySUPPLIER_NO", object).toString()));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public String updateSupplierBySupplier(Object object) {
        String returnString = "Y";
        try {
            this.insert("prostorage.Supplier.updateSupplierBySupplier", object);
        } catch (SQLException e) {
            returnString = e.getMessage();
            e.printStackTrace();
        }
        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List<HashMap> getExcelTitles(Map tmpParamMap) {
        List resultList = null;
        try {
            resultList = this.queryForList("prostorage.Supplier.querySuppliersColumnTitles", tmpParamMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String[] getColunmOptions(Map optionParamMap) {
        List list = null;
        try {
            list = this.queryForList("prostorage.Supplier.querySuppliersCellOptions", optionParamMap);
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
    public void createTempSupplierInfo(Map map) throws Exception {
        this.update("prostorage.Supplier.createTempSupplierInfo", map);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateTempSupplierTitles(List titleList) throws Exception {
        this.insertForList("prostorage.Supplier.updateTempSupplierTitles", titleList);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateTempSupplierInfo(List paramList) throws Exception {
        this.updateForList("prostorage.Supplier.updateTempSupplierInfo", paramList);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSupplierColumnList() throws Exception {
        return this.queryForList("prostorage.Supplier.getSupplierColumnList");
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSupplierTmpList() throws Exception {
        return this.queryForList("prostorage.Supplier.getSupplierTmpList");
    }

    @Override
    public void modifySupplierTmpTable() throws Exception {
        this.update("prostorage.Supplier.modifySupplierTmpTable");
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSupplierInsertList(Map paramMap) throws Exception {
        return this.queryForList("prostorage.Supplier.getSupplierInsertList", paramMap);
    }

    @Override
    public void insertSupplier(List<LinkedHashMap<String, Object>> requestListData) throws Exception {
        this.insertForList("prostorage.Supplier.insertSuppliers", requestListData);
    }

}
