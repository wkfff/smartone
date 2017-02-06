package com.siping.cust.dao;

import java.util.List;

public interface SupplierAccountSelfManagerDao {

	public String addSupplierAccountSelf(Object object);
	
	public String updateSupplierAccountSelf(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getSupplierAccountSelf(Object object,int currentPage,int pageSize);
	
	@SuppressWarnings("rawtypes")
	public String deleteSupplierAccountSelf(List objectList);
	
	
	public int getSupplierAccountSelfCnt(Object object);
	
	
	public String checkUsernameExist(Object object);
	

	//根据密码查找是否存在该用户
	public int getSupplierByPassword(Object object);
	
	//修改密码
	public String updateSupplierPassword(Object object);
	
	//切换用户状态
	public String toggleSupplierActivity(Object object);
	
}
