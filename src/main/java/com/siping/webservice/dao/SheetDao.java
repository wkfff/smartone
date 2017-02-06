package com.siping.webservice.dao;

import java.util.List;

import com.siping.productStorage.bean.SalesMode;
import com.siping.webservice.bean.ProductBean;
import com.siping.webservice.bean.ProductStorageBean;
import com.siping.webservice.bean.SalesDataBean;
import com.siping.webservice.bean.SalesModelBean;
import com.siping.webservice.bean.StorageBean;
import com.siping.webservice.bean.StorageInBean;
import com.siping.webservice.bean.StorageOutBean;

public interface SheetDao {
    public List<SalesDataBean> getSalesReport(Object obj);

    public List<StorageInBean> getStorageInReport(Object obj);

    public List<StorageOutBean> getStorageOutReport(Object obj);

    public List<ProductStorageBean> getProductStorageReport();

    public List<StorageBean> getStroageReport_MD();

    public List<ProductBean> getProductReport_MD();

    public List<SalesModelBean> getSalesModelReport_MD();
}
