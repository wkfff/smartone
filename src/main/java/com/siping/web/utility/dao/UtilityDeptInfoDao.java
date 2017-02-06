package com.siping.web.utility.dao;

import java.util.List;

public interface UtilityDeptInfoDao { 
	/**
	 * 获得部门下拉列表
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptSelectList(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getDeptTreeInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getDepartmentInfoList(Object obj) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getDepartmentInfoList(Object object, int currentPage, int pageSize);
	 
	public int getDepartmentInfoListCnt(Object object);	
}
