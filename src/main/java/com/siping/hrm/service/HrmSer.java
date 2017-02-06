package com.siping.hrm.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface HrmSer {
	
	public Object getDeptById(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getDeptTree(HttpServletRequest request, String limit);

	@SuppressWarnings({ "rawtypes" })
	public List getAllDept(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getAllConPer();
  
}
