package com.siping.webservice.dao.impl;

import java.sql.SQLException;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.siping.web.utility.SqlMapClientSupport;
import com.siping.webservice.bean.ProductBean;
import com.siping.webservice.bean.ProductStorageBean;
import com.siping.webservice.bean.SalesDataBean;
import com.siping.webservice.bean.SalesModelBean;
import com.siping.webservice.bean.StorageBean;
import com.siping.webservice.bean.StorageInBean;
import com.siping.webservice.bean.StorageOutBean;
import com.siping.webservice.dao.SheetDao;

@Repository
public class SheetDaoImpl extends SqlMapClientSupport implements SheetDao {

    @SuppressWarnings("unchecked")
    @Override
    public List<SalesDataBean> getSalesReport(Object obj) {
        List<SalesDataBean> resultList = null;
        try {
            resultList = (List<SalesDataBean>) this.queryForList("webservice.salesSheet.getSalesReport", obj);
        } catch (Exception e) {
            e.printStackTrace();
            resultList = null;
        }
        return resultList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<StorageInBean> getStorageInReport(Object obj) {
        List<StorageInBean> resultList = null;
        try {
            resultList = (List<StorageInBean>) this.queryForList("webservice.salesSheet.getStorageInReport", obj);
        } catch (Exception e) {
            e.printStackTrace();
            resultList = null;
        }
        return resultList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<StorageOutBean> getStorageOutReport(Object obj) {
        List<StorageOutBean> resultList = null;
        try {
            resultList = (List<StorageOutBean>) this.queryForList("webservice.salesSheet.getStorageOutReport", obj);
        } catch (Exception e) {
            e.printStackTrace();
            resultList = null;
        }
        return resultList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<ProductStorageBean> getProductStorageReport() {
        List<ProductStorageBean> resultList = null;
        try {
            resultList = (List<ProductStorageBean>) this.queryForList("webservice.salesSheet.getProductStorageReport");
        } catch (Exception e) {
            e.printStackTrace();
            resultList = null;
        }
        return resultList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<StorageBean> getStroageReport_MD() {
        List<StorageBean> resultList=null;
        try {
            resultList=(List<StorageBean>) this.queryForList("webservice.salesSheet.getStorageReport");
        } catch (SQLException e) {
            e.printStackTrace();
            resultList =null;
        }
        return resultList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<ProductBean> getProductReport_MD() {
        List<ProductBean> resultList=null;
        try {
            resultList=(List<ProductBean>) this.queryForList("webservice.salesSheet.getProductReport");
        } catch (SQLException e) {
            e.printStackTrace();
            resultList=null;
        }
        
        return resultList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<SalesModelBean> getSalesModelReport_MD() {
        List<SalesModelBean> resultList=null;
        try {
            resultList=(List<SalesModelBean>) this.queryForList("webservice.salesSheet.getSalesModelReport");
        } catch (SQLException e) {
            e.printStackTrace();
            resultList=null;
        }
        
        return resultList;
    }
}
