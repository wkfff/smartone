package com.siping.cust.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;


public interface SupplierProductManagerSer {

	public String addOrUpdateProduct(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
    public List getSupplierProductList(HttpServletRequest request);
	
	public String deleteSupplierProduct(HttpServletRequest request);
	
	public int getSupplierProductCnt(HttpServletRequest request);
	
	public int checkSupplierProIdCnt(HttpServletRequest request);
}
