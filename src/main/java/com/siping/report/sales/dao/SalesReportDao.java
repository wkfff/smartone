package com.siping.report.sales.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface SalesReportDao {
    @SuppressWarnings("rawtypes")
    public List<LinkedHashMap> getDatasource(List<String> codeList,Object obj);

    public List<String> getSalesMonthTitleInfo(Object obj); 
    
    public String getSalesMonthColumnInfo(Object obj); 
    
    @SuppressWarnings("rawtypes")
    public int insertComputer(List<Map> list);

    @SuppressWarnings("rawtypes")
    public List getCustomerMonthlySalesList(Object object, Integer page, Integer pageSize);
    
    @SuppressWarnings("rawtypes")
    public List getCustomerMonthlySalesList(Object object);

    public int getCustomerMonthlySalesCnt(Object object);
    
    @SuppressWarnings("rawtypes")
    public List getCustomerYearlySalesList(Object object, Integer page, Integer pageSize);
    
    @SuppressWarnings("rawtypes")
    public List getCustomerYearlySalesList(Object object);

    public int getCustomerYearlySalesCnt(Object object);

    @SuppressWarnings("rawtypes")
    public List getProductMonthlySalesList(Object object, Integer page, Integer pageSize);
    
    @SuppressWarnings("rawtypes")
    public List getProductMonthlySalesList(Object object);

    public int getProductMonthlySalesCnt(Object object);
    
    @SuppressWarnings("rawtypes")
    public List getProductYearlySalesList(Object object, Integer page, Integer pageSize);
    
    @SuppressWarnings("rawtypes")
    public List getProductYearlySalesList(Object object);

    public int getProductYearlySalesCnt(Object object);
}
