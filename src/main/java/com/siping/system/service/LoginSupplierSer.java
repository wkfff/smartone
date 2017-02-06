package com.siping.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface LoginSupplierSer {
 
	public Object getLoginSupplierInfoObj(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierRolesGroupList(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierInfo(HttpServletRequest request) ;
	 
	public int getLoginSupplierInfoCnt(HttpServletRequest request) ;
	 
	public String addLoginSupplierInfo(HttpServletRequest request) ;
	 
	public String updateLoginSupplierInfo(HttpServletRequest request) ;
	 
	public String deleteLoginSupplierInfo(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getLoginSupplierDeptInfo(HttpServletRequest request) ;
	  
	@SuppressWarnings({ "rawtypes" })
	public List getRolesSelectList(HttpServletRequest request) ;
	
}
