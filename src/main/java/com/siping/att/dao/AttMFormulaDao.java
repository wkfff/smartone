package com.siping.att.dao;

import java.util.List;

public interface AttMFormulaDao { 


	public Object getAttMFormulaObjectInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getAttMFormulaInfo(Object obj); 
	 
	public int getAttMFormulaInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getAttMFormulaInfo(Object object, int currentPage, int pageSize);
 
	@SuppressWarnings("rawtypes")
	public List getAttMFormulaItemInfo(Object obj) ;
	
	public int addAttMFormulaInfo(Object object);

	public int updateAttMFormulaInfo(Object object);

	public int deleteAttMFormulaInfo(Object object);
}
