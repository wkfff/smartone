package com.siping.productStorage.dao;

import com.siping.productStorage.bean.SalesMode;

import java.util.List;

public interface SalesModelDao {

    @SuppressWarnings({"rawtypes"})
    public List getSalesModelList(Object object);

    @SuppressWarnings({"rawtypes"})
    public List getSalesModelList(Object object, int currentPage, int pageSize);

    public int getSalesModelListCnt(Object object);

    public String addSalesModel(Object object);

    public String updateSalesModel(Object object);

    @SuppressWarnings("rawtypes")
    public String deleteSalesModel(List objlist);

    public int checkSalesDistri(Object object);

    public List<SalesMode> getAllSalesModes();

    public String updateSalesMobileStatus(Object object);
}
