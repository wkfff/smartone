package com.siping.att.dao;

import java.util.List;

public interface AttMonthDao {

	@SuppressWarnings("rawtypes")
	public List getAttColumns(Object object);

	@SuppressWarnings("rawtypes")
	public List getAttSqlColumns(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getAttMonthInfo(Object object);

	@SuppressWarnings("rawtypes")
	public List getAttMonthInfo(Object object, int currentPage, int pageSize);

	public int getAttMonthInfoCnt(Object object);
  
	public int updateAttMonthInfo(Object object);

}
