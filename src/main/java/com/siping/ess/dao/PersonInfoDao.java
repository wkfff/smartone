package com.siping.ess.dao;

import java.util.Map;

public interface PersonInfoDao {
	  
	@SuppressWarnings("rawtypes")
	public Map getEducationInfoList(Object object,int currentPage,int pageSize);

	@SuppressWarnings("rawtypes")
	public Map getEvaluateforList(Object object,int currentPage,int pageSize);
}
