package com.siping.mobile.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface MobileManageSer {
    @SuppressWarnings({"rawtypes"})
    public List getMobileAreaList(HttpServletRequest request);

    public int getMobileAreaListCnt(HttpServletRequest request);
    
    public String deleteMobileArea(HttpServletRequest request) ;
    
    public String saveOrUpdateMobileArea(HttpServletRequest request);
    
    public String saveProductToArea(HttpServletRequest request);
    
    @SuppressWarnings({"rawtypes"})
    public List getMobileAdv(HttpServletRequest request);

    public int getMobileAdvCnt(HttpServletRequest request);
    
    public String addOrUpdateMobileAdv(HttpServletRequest request);
    
    public String deleteMobileAdv(HttpServletRequest request);
    
    @SuppressWarnings({ "rawtypes" })
    public void getAllSonNode(List<HashMap> list,List reList,String pid);
    
    @SuppressWarnings("rawtypes")
    public void setSalePrice(List<HashMap> list,HashMap saleMode);
    
    @SuppressWarnings("rawtypes")
    public void setSonNodes(List<HashMap> list,List<HashMap> relist);
    
    @SuppressWarnings("rawtypes")
    public List getSalesModelList(HttpServletRequest request);
    
    public int addToCart(HttpServletRequest request);
    
    public String deleteFromCart(HttpServletRequest request);
    
    public void clearCart(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List getProductListBySalesOrder(HttpServletRequest request,String salesOrderNo);
    
    public String getSalesModeNoByCu(String cid);
}
