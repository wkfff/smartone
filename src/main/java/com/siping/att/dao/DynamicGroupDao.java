package com.siping.att.dao;

import java.util.List;

public interface DynamicGroupDao {

	public Object getDynamicGroup(Object obj);

	@SuppressWarnings("rawtypes")
	public List getDynamicGroupSelectionList(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getDynamicGroupList(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getDynamicGroupList(Object object, int currentPage, int pageSize);
	 
	public int getDynamicGroupCnt(Object object);

	@SuppressWarnings("rawtypes")
	public int addDynamicGroupInfo(List object);

	@SuppressWarnings("rawtypes")
	public int updateDynamicGroupInfo(List object);

	public int deleteDynamicGroupInfo(Object object);

	@SuppressWarnings("rawtypes")
	public List getLoginUserDeptList(Object object);

	@SuppressWarnings("rawtypes")
	public List getDynamicGroupEmpInfo(Object object);
	
	@SuppressWarnings("rawtypes") 
	public List getDynamicGroupEmpInfo(Object object, int currentPage, int pageSize);
	 
	public int getDynamicGroupEmpInfoCnt(Object object);

	@SuppressWarnings("rawtypes") 
	public int addDynamicGroupEmpInfo(List object);

	public int checkDynamicGroupEmpInfo(Object object);

	public int deleteDynamicGroupEmpInfo(Object object);
	

	@SuppressWarnings("rawtypes")
	public List getNonDynamicGroupEmpInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getNonDynamicGroupEmpInfo(Object object, int currentPage, int pageSize);
	 
	public int getNonDynamicGroupEmpInfoCnt(Object object);

}
