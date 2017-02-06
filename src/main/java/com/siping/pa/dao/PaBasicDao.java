package com.siping.pa.dao;

import java.util.List;

public interface PaBasicDao {
 
	@SuppressWarnings("rawtypes")
	public List getPaSearchEmployeeList(Object object);
	 
	public int getPaSearchEmployeeCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public List getPaSearchEmployeeList(Object object, int currentPage, int pageSize);
	
}
