package com.siping.att.dao;

import java.util.List;

public interface AttendanceKeeperDao {
	  
	public Object getAttendanceKeeper(Object obj) ;
	
	@SuppressWarnings("rawtypes")
	public List getAttendanceKeeperInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getAttendanceKeeperInfo(Object object, int currentPage, int pageSize);
	 
	public int getAttendanceKeeperInfoCnt(Object object);
	 
	public int addAttendanceKeeperInfo(Object object);
	 
	public int updateAttendanceKeeperInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public int addAttendanceKeeperDeptInfo(List object);
	 
	public int deleteAttendanceKeeperInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getAttendanceKeeperDeptInfo(Object object);
}
