package com.siping.productStorage.service;

import java.util.List;
import java.util.Map;

import com.siping.productStorage.bean.Product;
import com.siping.productStorage.bean.SalesOrder;
import com.siping.system.bean.AdminBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ProductSaleSer {
    String saveSalesOrder(SalesOrder salesOrder, HttpServletRequest request) throws Exception;

    List<SalesOrder> getAllSalesOrders(HttpServletRequest request);

    List<SalesOrder> getAllSalesOrders(HttpServletRequest request, int page, int pagesize);

    int getAllSalesOrdersCount(HttpServletRequest request);

    SalesOrder getSalesOrder(HttpServletRequest request, String salesOrderNo);

    List<SalesOrder> searchSalesOrder(HttpServletRequest request);

    String deleteSalesOrder(HttpServletRequest request, String salesOrderNo,String processId);
    Map getSalesOrderInfo(HttpServletRequest request) throws Exception;
    @SuppressWarnings("rawtypes")
    List getSalesOrderDetailForCheck(HttpServletRequest request) throws Exception;
    int getSalesOrderDetailForCheckCnt(HttpServletRequest request) throws Exception;
    String updateSalesOrderStatus(HttpServletRequest request) throws Exception;

    String salesOrderToExcel(HttpServletRequest request, HttpServletResponse response, String salesOrderNo);
    
    public List<Product> getProductBySalesOrder(HttpServletRequest request,SalesOrder s);

    void saleOrdersToExcel(HttpServletRequest request, HttpServletResponse response);
}
