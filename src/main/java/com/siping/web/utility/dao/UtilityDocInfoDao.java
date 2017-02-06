package com.siping.web.utility.dao;

import java.util.List;

public interface UtilityDocInfoDao {

	@SuppressWarnings("rawtypes")
	List getDocList(Object object);
	int getDocListCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	List getDocTypeList(Object object);
	int getDocTypeListCnt(Object object);

	
}
