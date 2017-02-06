package com.siping.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface SystemMenuSer {
  
	@SuppressWarnings("rawtypes")
	public List getSystemMenuInfo(HttpServletRequest request) ;
	 
	public int getSystemMenuInfoCnt(HttpServletRequest request) ;
	
}
