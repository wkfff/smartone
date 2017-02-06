package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface AttendanceKeeperSer {
 
	public Object getAttendanceKeeper(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getAttendanceKeeperInfo(HttpServletRequest request) ;
	 
	public int getAttendanceKeeperInfoCnt(HttpServletRequest request) ;
	 
	public int addAttendanceKeeperInfo(HttpServletRequest request) ;
	 
	public int updateAttendanceKeeperInfo(HttpServletRequest request) ;
	 
	public int deleteAttendanceKeeperInfo(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getAttendanceKeeperDeptInfo(HttpServletRequest request) ;
}
