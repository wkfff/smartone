package com.siping.pa.service.salary;

import java.util.List;

import javax.servlet.http.HttpServletRequest;


public interface PaProgressSer {
	
	public Object getPaProgressObjectInfo(HttpServletRequest request) ;
	
	
	@SuppressWarnings("rawtypes")
	public List getPaProgressInfo(HttpServletRequest request) ;	
	
	
	public int updatePaProgressInfo(HttpServletRequest request) ;
	
	
	public int getPaProgressPaLockFlag(HttpServletRequest request) ;
	
	public int getPaProgressLockFlag(HttpServletRequest request) ;
	
}
