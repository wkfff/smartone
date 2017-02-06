package com.siping.web.utility.dao;

import java.util.List;

public interface UtilityMatInfoDao {
	@SuppressWarnings({ "rawtypes" })
	public List getMaterialList(Object object);
	
	public int getMaterialListCnt(Object object);	

}
