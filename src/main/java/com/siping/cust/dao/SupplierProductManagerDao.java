package com.siping.cust.dao;

import java.util.List;

public interface SupplierProductManagerDao {

	public String addProduct(Object object);
	
	@SuppressWarnings("rawtypes")
    public List getSupplierProductList(Object object,int currentPage,int pageSize);
	
	@SuppressWarnings("rawtypes")
    public String deleteSupplierProduct(List list);
	
	public String updateSupplierProduct(Object object);
	
	public int getSupplierProductCnt(Object object);
	
	public int checkSupplierProIdCnt(Object object);
	
}
