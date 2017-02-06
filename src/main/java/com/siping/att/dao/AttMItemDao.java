package com.siping.att.dao;

import java.util.List;
 

public interface AttMItemDao {
	 
	public Object getAttMItemObjectInfo(Object obj) ;
	
	@SuppressWarnings("rawtypes")
	public List getAttMItemInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getAttMItemInfo(Object object, int currentPage, int pageSize);
	 
	public int getAttMItemInfoCnt(Object object);
	 
	public int addAttMItemInfo(Object object);
	 
	public int updateAttMItemInfo(Object object);
	 
	public int deleteAttMItemInfo(Object object);
	 
	public int checkDeleteAttMItemInfo(Object object) ;
	 
	@SuppressWarnings("rawtypes")
	public int updateAttMItemInfoCalOrder(List objList) ;
}
