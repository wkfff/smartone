package com.siping.system.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface LoginSupplierDao {
	 
	public Object getLoginSupplierInfoObj(Object obj) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierRolesGroupList(Object obj) ;

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierInfo(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierInfo(Object object, int currentPage, int pageSize);
	 
	public int getLoginSupplierInfoCnt(Object object);
	 
	public String addLoginSupplierInfo(Object object) throws SQLException;
	 
	public String updateLoginSupplierInfo(Object object);
	 
	public String deleteLoginSupplierInfo(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierDeptInfo(Object object) ;

	@SuppressWarnings({ "rawtypes" })
	public List getRolesSelectList(Object object) ;

	public int checkAdminID(Object object);
	
}
