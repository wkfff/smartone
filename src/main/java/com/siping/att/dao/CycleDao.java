package com.siping.att.dao;

import java.util.List;

public interface CycleDao {
	 
	public Object getCycleInfo(Object obj) ;
	
	@SuppressWarnings("rawtypes")
	public List getCycleInfoList(Object object);
	 
	public int getCycleInfoCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getCycleInfoList(Object object, int currentPage, int pageSize);
	 
	public int addCycleInfo(Object object);
	 
	public int updateCycleInfo(Object object);
	 
	public int deleteCycleInfo(Object object);
	
}
