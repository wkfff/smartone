package com.siping.process.dao;

import java.util.Map;

public interface ProcessAffirmDao {
    @SuppressWarnings("rawtypes")
    void updateSalesOrderStatusAgree(Map map) throws Exception;

    @SuppressWarnings("rawtypes")
    void updateSalesOrderStatusVeto(Map map) throws Exception;

    @SuppressWarnings("rawtypes")
    void updatePurchaseOrderStatusAgree(Map map) throws Exception;

    @SuppressWarnings("rawtypes")
    void updatePurchaseOrderStatusVeto(Map map) throws Exception;

    @SuppressWarnings("rawtypes")
    void updateHrApplicationAgree(Map map) throws Exception;

    @SuppressWarnings("rawtypes")
    void updateHrApplicationVeto(Map map) throws Exception;
    
//    @SuppressWarnings("rawtypes")
//    int getHrApplicationStatus(Map map) throws Exception;
}
