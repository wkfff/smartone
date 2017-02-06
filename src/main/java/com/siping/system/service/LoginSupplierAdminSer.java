package com.siping.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface LoginSupplierAdminSer {
 
	public Object getLoginSupplierAdminInfoObj(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierAdminRolesGroupList(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierAdminInfo(HttpServletRequest request) ;
	 
	public int getLoginSupplierAdminInfoCnt(HttpServletRequest request) ;
	 
	public String updateLoginSupplierAdminInfo(HttpServletRequest request) ;
	 
	public String deleteLoginSupplierAdminInfo(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierAdminDeptInfo(HttpServletRequest request) ;
	  
	@SuppressWarnings({ "rawtypes" })
	public List getRolesSelectList(HttpServletRequest request) ;
	
}
