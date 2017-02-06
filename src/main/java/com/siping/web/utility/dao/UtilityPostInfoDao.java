package com.siping.web.utility.dao;

import java.util.List;

public interface UtilityPostInfoDao {
	@SuppressWarnings("rawtypes")
	public List getPostInfoList(Object object);

	@SuppressWarnings("rawtypes")
	public List getPostInfoList(Object object, int currentPage, int pageSize);

	public int getPostInfoCnt(Object object);
}
