package com.siping.productStorage.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ProductInStorageSer {
    @SuppressWarnings("rawtypes")
    public List getProInColumns(HttpServletRequest request);

    @SuppressWarnings("rawtypes")
    public List getSupplierList(HttpServletRequest request);

    public String productInStore(HttpServletRequest request) throws Exception;

    @SuppressWarnings({ "rawtypes" })
    public List getInstorageList(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getPurchaseOrderList(Map paramMap);

    @SuppressWarnings("rawtypes")
    public int getPurchaseOrderListCnt(Map paramMap);

    public int getWaitingInStorageSum(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getProductWaitingInfo(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getInStorHistoryList(HttpServletRequest request);

    public int getInStorHistoryListCnt(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getInStorDetailList(HttpServletRequest request);

    public int getInStorDetailListCnt(HttpServletRequest request);

    public void viewProInstorReport(HttpServletRequest request, HttpServletResponse response);

    @SuppressWarnings("rawtypes")
    public Map getInstorOrderById(HttpServletRequest request);

    public void exportInstorRecords(HttpServletRequest request, HttpServletResponse response);
}
