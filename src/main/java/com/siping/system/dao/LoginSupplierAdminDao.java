package com.siping.system.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface LoginSupplierAdminDao {
	 
	public Object getLoginSupplierAdminInfoObj(Object obj) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierAdminRolesGroupList(Object obj) ;

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierAdminInfo(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierAdminInfo(Object object, int currentPage, int pageSize);
	 
	public int getLoginSupplierAdminInfoCnt(Object object);
	 
	public String addLoginSupplierAdminInfo(Object object) throws SQLException;
	 
	public String updateLoginSupplierAdminInfo(Object object);
	 
	public String deleteLoginSupplierAdminInfo(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierAdminDeptInfo(Object object) ;

	@SuppressWarnings({ "rawtypes" })
	public List getRolesSelectList(Object object) ;

	public int checkAdminID(Object object);
	
}
