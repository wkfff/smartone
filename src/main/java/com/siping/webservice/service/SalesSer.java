package com.siping.webservice.service;

import javax.jws.WebService;

import com.siping.webservice.bean.ProductBean;
import com.siping.webservice.bean.ProductStorageBean;
import com.siping.webservice.bean.SalesDataBean;
import com.siping.webservice.bean.SalesModelBean;
import com.siping.webservice.bean.StorageBean;
import com.siping.webservice.bean.StorageInBean;
import com.siping.webservice.bean.StorageOutBean;

@WebService(targetNamespace = "webservice.siping.com")
public interface SalesSer {
    public SalesDataBean[] getSalesReport(String sdate, String edate,String entity) throws Exception;

    public StorageInBean[] getStorageInReport(String yearMonth) throws Exception;

    public StorageOutBean[] getStorageOutReport(String yearMonth) throws Exception;

    public ProductStorageBean[] getProductStorageReport() throws Exception;

    public StorageBean[] getStorageReport_MD() throws Exception;

    public ProductBean[] getProductReport_MD() throws Exception;

    public SalesModelBean[] getSalesModelReport_MD() throws Exception;
}
