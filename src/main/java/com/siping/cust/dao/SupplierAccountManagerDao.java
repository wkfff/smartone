package com.siping.cust.dao;

import java.util.List;

public interface SupplierAccountManagerDao {

	public String addSupplierAccount(Object object);
	
	public String updateSupplierAccount(Object object);
	
	@SuppressWarnings("rawtypes")
	public List findSupplierAccount(Object object,int currentPage,int pageSize);
	
	@SuppressWarnings("rawtypes")
	public String deleteSupplierAccount(List objectList);
	
	
	public int getSupplierAccountCnt(Object object);
	
	
	public String checkUsernameExist(Object object);
	

	//根据密码查找是否存在该用户
	public int getSupplierByPassword(Object object);
	
	//修改密码
	public String updateSupplierPassword(Object object);
	
	//切换供应商的状态
	public String toggleSupplierActivity(Object object);
	
}
