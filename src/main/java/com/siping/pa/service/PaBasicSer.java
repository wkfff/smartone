package com.siping.pa.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface PaBasicSer {
	 
	@SuppressWarnings("rawtypes")
	public List getPaSearchEmployeeList(HttpServletRequest request) ;
	 
	public int getPaSearchEmployeeCnt(HttpServletRequest request);
}
