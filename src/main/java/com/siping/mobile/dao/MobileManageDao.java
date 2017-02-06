package com.siping.mobile.dao;

import java.util.List;

public interface MobileManageDao {
    @SuppressWarnings({ "rawtypes" })
    public List getMobileAreaList(Object object);
    @SuppressWarnings({ "rawtypes" })
    public List getMobileAreaList(Object object,int currentPage,int pageSize);
    
    public int getMobileAreaListCnt(Object object);
    
    public String deleteMobileArea(Object object);
    
    @SuppressWarnings("rawtypes")
    public String addMobileAreaInfo(List list);
    
    @SuppressWarnings("rawtypes")
    public String updateMobileAreaInfo(List list);
    
    public String deleteProductByArea(Object obj);
    
    @SuppressWarnings("rawtypes")
    public String saveProductToArea(List list);
    
    @SuppressWarnings({ "rawtypes" })
    public List getMobileAdv(Object object);
    
    public int getMobileAdvCnt(Object object);
    
    public String addOrUpdateMobileAdv(Object obj);
    
    public String deleteMobileAdv(Object obj);
    
    public String getSalesModeNoByCu(String cid);
}
