package com.siping.productStorage.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface ProductStorageManageDao {
    @SuppressWarnings("rawtypes")
    public List getSaleOrderList(Object object, int currentPage, int pageSize);

    public int getSaleOrderListCnt(Object object);

    @SuppressWarnings("rawtypes")
    public List getSalesOrderDetail(Object object, int currentPage, int pageSize);

    public int getSalesOrderDetailCnt(Object object);

    @SuppressWarnings("rawtypes")
    public List getSalesOrderInfo(Object object, int currentPage, int pageSize);

    public int getSalesOrderInfoCnt(Object object);

    public Double getLeftQuantity(Object object);

    public String getSerialNum();

    public String insertOutInfo(Object object) throws Exception;

    @SuppressWarnings("rawtypes")
    public List viewOutStorHistoryList(Object object, int currentPage, int pageSize);

    public int viewOutStorHistoryListCnt(Object object);

    @SuppressWarnings("rawtypes")
    public List viewOutStorHistoryDetail(Object object, int currentPage, int pageSize);

    @SuppressWarnings("rawtypes")
    public List viewOutStorHistoryDetail(Object object);

    public int viewOutStorHistoryDetailCnt(Object object);

    public String getOutStorExcelColumnInfo(Object object);

    public List<String> getOutStorExcelTitleInfo(Object object);

    @SuppressWarnings("rawtypes")
    public List<LinkedHashMap> getOutStorDatasource(Map paramMap);

    public Double getMinStorQuantity(Object object);

    @SuppressWarnings("rawtypes")
    public Map getOutstorageOrderById(Object object);

    public String insertOutDetailForList(List<LinkedHashMap<String, Object>> jsonList) throws Exception;

    @SuppressWarnings("rawtypes")
    LinkedHashMap<String, Object> viewSaleOrderDetail(Map paramMap) throws Exception;

    public String checkReceiverPhoneNum(String saleOrderNo) throws Exception;
}
