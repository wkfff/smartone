package com.siping.pa.service.salary;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public interface PaResultSer {
	
	@SuppressWarnings("rawtypes")
	public Map getPaResultAllItem(HttpServletRequest request) ;		
	
	public String paBalance(HttpServletRequest request) ;

	@SuppressWarnings("rawtypes")
	public List getPaColumns(HttpServletRequest request);
}
