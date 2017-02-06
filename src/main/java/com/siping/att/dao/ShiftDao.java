package com.siping.att.dao;

import java.util.List;

public interface ShiftDao {
	 
	public Object getShiftInfo(Object obj) ;
	 
	@SuppressWarnings("rawtypes")
	public List getShiftInfoList(Object object);
	 
	@SuppressWarnings("rawtypes")
	public List getShiftSelectionList(Object object);
	
	public int getShiftInfoCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getShiftInfoList(Object object, int currentPage, int pageSize);

	@SuppressWarnings("rawtypes")
	public int addShiftInfo(List object);

	public int checkShiftInfo(Object object) ;

	public int deleteShiftInfo(Object object);

	@SuppressWarnings("rawtypes")
	public int updateShiftInfo(List object);
 
	public Object getShiftParameterInfoObj(Object obj) ;

	@SuppressWarnings("rawtypes")
	public List getShiftParameterInfo(Object object);

	public int updateShiftParameterInfo(Object object);
	 
	public int addShiftParameterInfo(Object object);
	
	public int deleteShiftParameterInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getShiftGroupInfoList(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getShiftGroupInfoList(Object object, int currentPage, int pageSize);
	
	public int getShiftGroupInfoListCnt(Object object);
	
	public int checkShiftGroupInfo(Object object) ;
	
	@SuppressWarnings("rawtypes")
	public int addShiftGroupInfo(List object);
	
	@SuppressWarnings("rawtypes")
	public int updateShiftGroupInfo(List object);
	
	public int deleteShiftGroupInfo(Object object);
	
	public Object getShiftGroupInfo(Object obj) ;
	
	@SuppressWarnings("rawtypes")
	public int deleteShiftGroupEmpInfo(List empList);
	
	@SuppressWarnings("rawtypes") 
	public int addGroupEmpInfo(List object);
	
	@SuppressWarnings("rawtypes")
	public List getShiftGroupEmpInfoList(Object object);

	@SuppressWarnings("rawtypes")
	public List getShiftGroupEmpInfoList(Object object, int currentPage, int pageSize);
	 
	public int getShiftGroupEmpInfoListCnt(Object object);
	
	public int checkShiftGroupEmpDate(Object object) ;
}
