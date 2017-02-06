package com.siping.process.service;

public interface ProcessAffirmSer {
    void updateSalesOrderStatusAgree(String processId,String processName) throws Exception;

    void updateSalesOrderStatusVeto(String processName, String processInstanceId) throws Exception;

    void updatePurchaseOrderStatusAgree(String processName, String processInstanceId) throws Exception;

    void updatePurchaseOrderStatusVeto(String processName, String processInstanceId) throws Exception;

    void updateHrApplicationAgree(String processName, String processInstanceId) throws Exception;

    void updateHrApplicationVeto(String processName, String processInstanceId) throws Exception;
    
    int getHrApplicationStatus(String empId) throws Exception;
}
