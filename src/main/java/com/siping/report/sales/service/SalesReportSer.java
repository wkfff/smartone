package com.siping.report.sales.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SalesReportSer {
    public void viewSalesMonthReport(HttpServletRequest request, HttpServletResponse response);
    @SuppressWarnings("rawtypes")
    public List getSalesMonthTitleInfo(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List getCustomerMonthlySalesList(HttpServletRequest request);
    
    public int getCustomerMonthlySalesCnt(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List getCustomerYearlySalesList(HttpServletRequest request);
    
    public int getCustomerYearlySalesCnt(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List getProductMonthlySalesList(HttpServletRequest request);
    
    public int getProductMonthlySalesCnt(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List getProductYearlySalesList(HttpServletRequest request);
    
    public int getProductYearlySalesCnt(HttpServletRequest request);
}
