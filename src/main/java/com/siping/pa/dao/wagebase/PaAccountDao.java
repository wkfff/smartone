package com.siping.pa.dao.wagebase;

import java.util.LinkedHashMap;
import java.util.List;


public interface PaAccountDao { 
	@SuppressWarnings("rawtypes")
	public List getPaAccountInfo(Object object) ;
	 
	public int getPaAccountInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public List getPaAccountInfo(Object object, int currentPage, int pageSize);
	 
	@SuppressWarnings("rawtypes")
	public String updatePaAccountInfo(List list);

	@SuppressWarnings("rawtypes")
	public List getPaWhInfoList(Object object);
	
	public int getPaWhInfoListCnt(Object object);
	
}
