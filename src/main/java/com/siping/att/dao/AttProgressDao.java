package com.siping.att.dao;

import java.util.List;

public interface AttProgressDao {
	 
	@SuppressWarnings("rawtypes")
	public List getAttProgressInfo(Object object); 
	
	public int updateAttProgressInfo(Object object) ;

}
