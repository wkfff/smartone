package com.siping.productStorage.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ProductStorageManageSer {

    @SuppressWarnings("rawtypes")
    public List getSaleOrderList(Map paramMap) throws Exception;

    @SuppressWarnings("rawtypes")
    public int getSaleOrderListCnt(Map paramMap);

    @SuppressWarnings("rawtypes")
    public List getSalesOrderDetail(HttpServletRequest request);

    public int getSalesOrderDetailCnt(HttpServletRequest request);

    @SuppressWarnings("rawtypes")
    public List getSalesOrderInfo(HttpServletRequest request);

    public int getSalesOrderInfoCnt(HttpServletRequest request);

    @SuppressWarnings("rawtypes")
    public List viewSaleOrderDetailInfo(HttpServletRequest request);

    public int viewSaleOrderDetailInfoCnt(HttpServletRequest request);

    public Double getLeftQuantity(HttpServletRequest request);

    public String saveOutStorage(HttpServletRequest request) throws Exception;

    @SuppressWarnings("rawtypes")
    public List viewOutStorHistoryList(HttpServletRequest request);

    public int viewOutStorHistoryListCnt(HttpServletRequest request);

    @SuppressWarnings("rawtypes")
    public List viewOutStorHistoryDetail(HttpServletRequest request);

    public int viewOutStorHistoryDetailCnt(HttpServletRequest request);

    public String exportOutStorInfo(HttpServletRequest request, HttpServletResponse response);

    public Double getMinStorQuantity(HttpServletRequest request);

    @SuppressWarnings("rawtypes")
    public Map getOutstorageOrderById(HttpServletRequest request);

    LinkedHashMap<String, Object> viewSaleOrderDetail(HttpServletRequest request) throws Exception;

    public String checkReceiverPhoneNum(String saleOrderNo) throws Exception;
}
