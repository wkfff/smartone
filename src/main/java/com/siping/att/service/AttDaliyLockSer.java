package com.siping.att.service;
  
import javax.servlet.http.HttpServletRequest;

public interface AttDaliyLockSer {
 
	public int updateAttDaliyLockInfo(HttpServletRequest request);
	 
	public String getAttDaliyLockInfoHtml(HttpServletRequest request) ;
}
