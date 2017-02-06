package com.siping.webservice.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.webservice.bean.ProductBean;
import com.siping.webservice.bean.ProductStorageBean;
import com.siping.webservice.bean.SalesDataBean;
import com.siping.webservice.bean.SalesModelBean;
import com.siping.webservice.bean.StorageBean;
import com.siping.webservice.bean.StorageInBean;
import com.siping.webservice.bean.StorageOutBean;
import com.siping.webservice.dao.SheetDao;
import com.siping.webservice.service.SalesSer;

@WebService(endpointInterface = "com.siping.webservice.service.SalesSer", serviceName = "SheetSer", targetNamespace = "webservice.siping.com")
@Service(value = "SalesSheetSerImpl")
public class SalesSerImpl implements SalesSer {

    @Autowired
    private SheetDao salesDaoImpl;

    @Override
    @WebMethod(operationName = "getSalesReport")
    public SalesDataBean[] getSalesReport(@WebParam(name="sdate")String sdate, @WebParam(name="edate")String edate, @WebParam(name="entity")String entity) throws Exception {
        LinkedHashMap<String, Object> paramMap = new LinkedHashMap<String, Object>();
        String dateFormat;//定义查询条件是按照年、月、日中的哪一种格式查询
        if(sdate!=null)
        {
            if(sdate.length()==4) {
                dateFormat="yyyy";
            }
            else if( sdate.length()==6) {
                dateFormat="yyyymm";
                }
            else {
                dateFormat="yyyymmdd";
            }
        }else {
            {
                dateFormat="yyyymmdd";
            }
        }
        if(edate==null)
        {
            edate=sdate;
        }
        //格式化查询字段，这里用来用于动态查询
        if(entity!=null)
        {
            if(entity.equalsIgnoreCase("P")) {
                entity="PSOD.PRODUCT_NAME";
            }
            else if(entity.equalsIgnoreCase("C")) {
                entity="CBI.CUST_NAME";
            }
            else if(entity.equalsIgnoreCase("E")) {
                entity="HE.CHINESENAME";
            }
            else if(entity.equalsIgnoreCase("M")){
                entity="PSM.SALES_MODE_NAME";
            }else {
                entity="";
            }
        }else {
            entity="";
        }
        paramMap.put("S_DATE", sdate);
        paramMap.put("E_DATE", edate);
        paramMap.put("DATEFORMAT", dateFormat);
        paramMap.put("ENTITY", entity);
        List<SalesDataBean> resultList = this.salesDaoImpl.getSalesReport(paramMap);
        SalesDataBean[] returnArray = new SalesDataBean[resultList == null ? 0 : resultList.size()];
        list2array(resultList, returnArray);
        return returnArray;
    }

    @Override
    @WebMethod(operationName = "getStorageInReport")
    public StorageInBean[] getStorageInReport(@WebParam(name="yearMonth")String yearMonth) throws Exception {
        LinkedHashMap<String, Object> paramMap = new LinkedHashMap<String, Object>();
        paramMap.put("MONTH", yearMonth);
        List<StorageInBean> resultList = this.salesDaoImpl.getStorageInReport(paramMap);
        StorageInBean[] returnArray = new StorageInBean[resultList == null ? 0 : resultList.size()];
        list2array(resultList, returnArray);
        return returnArray;
    }

    @Override
    @WebMethod(operationName = "getStorageOutReport")
    public StorageOutBean[] getStorageOutReport(@WebParam(name="yearMonth")String yearMonth) throws Exception {
        LinkedHashMap<String, Object> paramMap = new LinkedHashMap<String, Object>();
        paramMap.put("MONTH", yearMonth);
        List<StorageOutBean> resultList = this.salesDaoImpl.getStorageOutReport(paramMap);
        StorageOutBean[] returnArray = new StorageOutBean[resultList == null ? 0 : resultList.size()];
        list2array(resultList, returnArray);
        return returnArray;
    }

    @Override
    @WebMethod(operationName = "getProductStorageReport")
    public ProductStorageBean[] getProductStorageReport() throws Exception {
        List<ProductStorageBean> resultList = this.salesDaoImpl.getProductStorageReport();
        ProductStorageBean[] returnArray = new ProductStorageBean[resultList == null ? 0 : resultList.size()];
        list2array(resultList, returnArray);
        return returnArray;
    }

    @Override
    @WebMethod(operationName = "getStorageReport_MD")
    public StorageBean[] getStorageReport_MD() throws Exception {
        List<StorageBean> resultList = this.salesDaoImpl.getStroageReport_MD();
        StorageBean[] returnArray=new StorageBean[resultList == null ? 0 : resultList.size()];
        list2array(resultList, returnArray);
        return returnArray;
    }

    @Override
    @WebMethod(operationName = "getProductReport_MD")
    public ProductBean[] getProductReport_MD() throws Exception {
        List<ProductBean> resultList=this.salesDaoImpl.getProductReport_MD();
        ProductBean [] returnArray = new ProductBean[resultList == null ? 0 :resultList.size()];
        list2array(resultList, returnArray);
        return returnArray;
    }

    @Override
    @WebMethod(operationName = "getSalesModelReport_MD")
    public SalesModelBean[] getSalesModelReport_MD() throws Exception {
        List<SalesModelBean> resultList=this.salesDaoImpl.getSalesModelReport_MD();
        SalesModelBean [] returnArray = new SalesModelBean[resultList == null ? 0 :resultList.size()];
        list2array(resultList, returnArray);
        return returnArray;
    }

    public <T> void list2array(List<T> list, T[] result) {
        if (list == null) {
            result = null;
        } else {
            list.toArray(result);
        }
    }
}