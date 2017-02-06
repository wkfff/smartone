package com.siping.att.dao;

import java.util.List;
import java.util.Map;

public interface AttDetailDao {
	@SuppressWarnings("rawtypes")
	public List getAttDetailList(Object object);
	  
	@SuppressWarnings("rawtypes")
	public List getAttDetailList(Object object, int currentPage, int pageSize);

	public int getAttDetailListCnt(Object object);

	public int getStartDateStr(Object object);

	public int getEndDateStr(Object object);

	@SuppressWarnings("rawtypes")
	public int updateAttDetailInfo(List list);
   
	@SuppressWarnings("rawtypes")
	public Map validateDetailItemType(Object object);

	@SuppressWarnings("rawtypes")
	public int deleteAttDetailInfo(List list);
   
	public int addAttDetailInfo(Object object);
	
}
