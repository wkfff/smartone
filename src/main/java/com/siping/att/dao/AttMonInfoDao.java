package com.siping.att.dao;

import java.util.List;

public interface AttMonInfoDao {

	@SuppressWarnings("rawtypes")
	public List getAttColumns(Object object);

	@SuppressWarnings("rawtypes")
	public List getAttSqlColumns(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getAttMonInfo(Object object);

	@SuppressWarnings("rawtypes")
	public List getAttMonInfo(Object object, int currentPage, int pageSize);

	public int getAttMonInfoCnt(Object object);
  
}
