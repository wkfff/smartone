package com.siping.att.dao;

import java.util.List;

public interface ItemsDao {
	 
	public Object getItemObjectInfo(Object obj) ;
	
	@SuppressWarnings("rawtypes")
	public List getItemInfo(Object object);
	
	public int getItemInfoCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getItemInfo(Object object, int currentPage, int pageSize);
	
	@SuppressWarnings("rawtypes")
	public List getItemInfoSelection(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getAppTypeSelectionList(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getItemInfoTree(Object object);
	 
	public int addItemInfo(Object object);
	
	public int checkItemInfo(Object object);
	
	public int updateItemInfo(Object object);
	 
	public int deleteItemInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getItemParameterInfoList(Object object);
	 
	public Object getItemParameterInfo(Object object);
	 
	public int addItemParameterInfo(Object object);
	 
	public int updateItemParameterInfo(Object object);
	 
	public int deleteItemParameterInfo(Object object);
}
