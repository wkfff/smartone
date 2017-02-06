package com.siping.cust.dao;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface SupplierManagerDao {

    public String addProduct(Object object);

    @SuppressWarnings("rawtypes")
    public List getSupplierModelList(Object object, int currentPage, int pageSize);

    @SuppressWarnings("rawtypes")
    public List getSuppliserModelList(Object object);

    @SuppressWarnings("rawtypes")
    public String deleteSupplierModel(Map map);

    public String updateSupplierModel(Object object);

    public int getSupplierModelCnt(Object object);

    public Object getSupplierDetatil(Object object);

    // 获取供货商的商品数量
    public int getSupplierProductCountCnt(Object object);

    // 供应商自己修改信息
    public String updateSupplierBySupplier(Object object);

    @SuppressWarnings("rawtypes")
    public List<HashMap> getExcelTitles(Map tmpParamMap);

    @SuppressWarnings("rawtypes")
    public String[] getColunmOptions(Map optionParamMap);

    @SuppressWarnings("rawtypes")
    public void createTempSupplierInfo(Map map) throws Exception;

    @SuppressWarnings("rawtypes")
    public void updateTempSupplierTitles(List titleList) throws Exception;

    @SuppressWarnings("rawtypes")
    public void updateTempSupplierInfo(List paramList) throws Exception;

    @SuppressWarnings("rawtypes")
    public List getSupplierColumnList() throws Exception;

    @SuppressWarnings("rawtypes")
    public List getSupplierTmpList() throws Exception;

    public void modifySupplierTmpTable() throws Exception;

    @SuppressWarnings("rawtypes")
    public List getSupplierInsertList(Map paramMap) throws Exception;

    public void insertSupplier(List<LinkedHashMap<String, Object>> requestListData) throws Exception;
}
