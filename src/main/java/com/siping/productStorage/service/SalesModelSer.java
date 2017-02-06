package com.siping.productStorage.service;

import com.siping.productStorage.bean.SalesMode;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

public interface SalesModelSer {
    @SuppressWarnings({"rawtypes"})
    public List getSalesModelList(HttpServletRequest request);

    public int getSalesModelListCnt(HttpServletRequest request);

    public String addOrUpdateSalesModel(HttpServletRequest request);

    public String deleteSalesModel(HttpServletRequest request);

    public int checkSalesDistri(HttpServletRequest request);

    public List<SalesMode> getAllSalesModes();

    public String updateSalesMobileStatus(HttpServletRequest request);
}
