package com.siping.pa.dao.salary;

import java.util.List;


public interface PaProgressDao {
	 
	public Object getPaProgressObjectInfo(Object obj) ;
	 
	@SuppressWarnings("rawtypes")
	public List getPaProgressInfo(Object object) ;
	 
	public int updatePaProgressInfo(Object object) ;
	
}
