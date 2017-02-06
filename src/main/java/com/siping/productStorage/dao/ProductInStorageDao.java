package com.siping.productStorage.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface ProductInStorageDao {
    @SuppressWarnings("rawtypes")
    public List getProInColumns(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getSupplierList(Object object);

    @SuppressWarnings("rawtypes")
    public String productInStore(List objlist) throws Exception;

    public String getInStorageSerialNum();

    public String addInStorageList(Object object) throws Exception;

    @SuppressWarnings({ "rawtypes" })
    public List getInstorageList(Object object);

    public String updateInStorage(Object object) throws Exception;

    @SuppressWarnings({ "rawtypes" })
    public List getPurchaseOrderList(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getPurchaseOrderList(Object object, int currentPage, int pageSize);

    public int getPurchaseOrderListCnt(Object object);

    public int getWaitingInStorageSum(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProductWaitingInfo(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getInStorHistoryList(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getInStorHistoryList(Object object, int currentPage, int pageSize);

    public int getInStorHistoryListCnt(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getInStorDetailList(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getInStorDetailList(Object object, int currentPage, int pageSize);

    public int getInStorDetailListCnt(Object object);

    @SuppressWarnings("rawtypes")
    public Map getInstorOrderById(Object object);

    @SuppressWarnings("rawtypes")
    public List<LinkedHashMap> getInstorRecords(Map paramMap);
}
