package com.siping.productStorage.dao;

import com.siping.productStorage.bean.Product;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface ProductDao {

    @SuppressWarnings({ "rawtypes" })
    public List getProductList(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProductList(Object object, int currentPage, int pageSize);

    public int getProductListCnt(Object object);

    public String addProduct(Object object);

    @SuppressWarnings("rawtypes")
    public List getProColumns(Object object);

    public String updateProduct(Object object);

    public int checkProductId(Object object);

    @SuppressWarnings("rawtypes")
    public String deleteProduct(List objlist);

    @SuppressWarnings({ "rawtypes" })
    public List getProductSymple(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProductByOrder(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProStorageDetail(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProSaleDetail(Object object);

    @SuppressWarnings("rawtypes")
    public List getProPropertyValueDetail(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProStorDetailList(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProStorDetailList(Object object, int currentPage, int pageSize);

    public int getProStorDetailListCnt(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProSaleDetailList(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProSaleDetailList(Object object, int currentPage, int pageSize);

    public int getProSaleDetailListCnt(Object object);

    @SuppressWarnings("rawtypes")
    List<Product> getProductsBySalesMode(Map paramMap);

    @SuppressWarnings("rawtypes")
    public String addProductForList(List objlist);

    @SuppressWarnings("rawtypes")
    public String updateProductForListById(List objlist);

    public String getProductNoById(Object obj);

    public String getProductIdSerial();

    @SuppressWarnings("rawtypes")
    public List<HashMap> getTitles(Map tmpParamMap);

    @SuppressWarnings("rawtypes")
    public String[] getOptions(Map optionParamMap);

    @SuppressWarnings("rawtypes")
    public void createTmpProductInfo(Map map) throws Exception;

    @SuppressWarnings("rawtypes")
    public void updateTmpProductTitles(List titleList) throws Exception;

    @SuppressWarnings("rawtypes")
    public void updateTmpProductInfo(List paramList) throws Exception;

    @SuppressWarnings("rawtypes")
    public List getProColumnList() throws Exception;

    @SuppressWarnings("rawtypes")
    public List getProTmpInfoList() throws Exception;

    public void modifyProTmpTable() throws Exception;

    @SuppressWarnings("rawtypes")
    public List getProInsertList(Map paramMap) throws Exception;

    public void insertPro(List<LinkedHashMap<String, Object>> requestListData) throws Exception;
}
