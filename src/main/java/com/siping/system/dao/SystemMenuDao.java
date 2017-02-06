package com.siping.system.dao;

import java.util.List;

public interface SystemMenuDao { 

	@SuppressWarnings({ "rawtypes" })
	public List getSystemMenuInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getSystemMenuInfo(Object object, int currentPage, int pageSize);

	public int getSystemMenuInfoCnt(Object object);
}
