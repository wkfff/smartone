package com.siping.productStorage.dao;

import com.siping.productStorage.bean.Product;
import com.siping.productStorage.bean.SalesOrder;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface ProductSaleDao {
	String insertSalesOrder(SalesOrder obj) throws Exception;

    List<SalesOrder> getAllSalesOrders(Object obj);

    List<SalesOrder> getAllSalesOrders(Object obj, int page, int pagesize);

    int getAllSalesOrdersCount(Object obj);

    SalesOrder getSalesOrder(Object obj);

    SalesOrder getSalesOrderById(Object obj);

    String getSalesOrderId();

    List<SalesOrder> searchSalesOrder(Object obj);

    String deleteSalesOrder(Object obj);

    @SuppressWarnings("rawtypes")
    List getSalesOrderDetailForCheck(Object object, int currentPage,int pageSize) throws Exception;

    @SuppressWarnings("rawtypes")
    List getSalesOrderDetailForCheck(Object object) throws Exception;

    int getSalesOrderDetailForCheckCnt(Object object) throws Exception;

    @SuppressWarnings("rawtypes")
    Map getSalesOrderInfo(Object object) throws Exception;

    String updateSalesOrderStatus0(Object object) throws Exception;

    String updateSalesOrderStatus1(Object object) throws Exception;

    public List<Product> getProductBySalesOrder(Object object);

    @SuppressWarnings("rawtypes")
    List<LinkedHashMap> getSaleOrdersRecords(Map paramMap);
}
