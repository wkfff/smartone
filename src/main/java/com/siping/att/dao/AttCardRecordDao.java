package com.siping.att.dao;

import java.sql.SQLException;

import java.util.LinkedHashMap;
import java.util.List;

public interface AttCardRecordDao {
	@SuppressWarnings("rawtypes")
	public List getAttCardRecordInfo(Object object);
	@SuppressWarnings("rawtypes")
	public List getAttCardRecordInfo(Object object,int currentPage, int pageSize);
	 
	public int getAttCardRecordInfoCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public int updateAttCardRecordInfo(List list);
	
	@SuppressWarnings("rawtypes")
	public int deleteAttCardRecordInfo(List list);
	 
	public int addAttCardRecordInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public void addAtrecordInfoList(List<LinkedHashMap> list) throws SQLException;
}
