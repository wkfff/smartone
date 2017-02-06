package com.siping.cust.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface SupplierAccountSelfManagerSer {

	public String addOrUpdateSupplierAccountSelf(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getSupplierModelList(HttpServletRequest request);
	
	public String deleteSupplierAccountSelf(HttpServletRequest request);
	
	public int getSupplierModelCnt(HttpServletRequest request);
	
	public String checkUsernameExist(HttpServletRequest request);
	
	public int getSupplierByPassword(HttpServletRequest request);
	
	public String updateSupplierPassword(HttpServletRequest request);
	
	public String toggleSupplierActivity(HttpServletRequest request);
}
