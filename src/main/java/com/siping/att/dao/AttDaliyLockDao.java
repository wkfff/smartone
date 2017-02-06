package com.siping.att.dao;

import java.util.List; 

public interface AttDaliyLockDao {
	 
	@SuppressWarnings("rawtypes")
	public List getAttDaliyLockInfo(Object object);
	 
	public int validateDailyLock(Object object);

	public int addDailyLock(Object object);
 
	public int updateAttDaliyLockInfo(Object object);
  
	
}
