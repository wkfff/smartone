package com.siping.web.utility.dao;

import java.util.List;

public interface UtilityProjInfoDao {
	@SuppressWarnings("rawtypes")
	List getProjectProcessList(Object object);
	
	int getProjectProcessListCnt(Object object);
	
}
