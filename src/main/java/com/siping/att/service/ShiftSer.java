package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface ShiftSer {
	public Object getShiftInfo(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getShiftInfoList(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getShiftSelectionList(HttpServletRequest request) ;

	public int getShiftInfoCnt(HttpServletRequest request) ;
	 
	public int addShiftInfo(HttpServletRequest request) ;
	 
	public int checkShiftInfo(HttpServletRequest request) ;

	public int updateShiftInfo(HttpServletRequest request) ;
	 
	public int deleteShiftInfo(HttpServletRequest request) ;

	public Object getShiftParameterInfoObj(HttpServletRequest request) ;

	public int updateShiftParameterInfo(HttpServletRequest request) ;
	
	public int addShiftParameterInfo(HttpServletRequest request) ;

	public int deleteShiftParameterInfo(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getShiftParameterInfo(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getShiftGroupInfoList(HttpServletRequest request) ;

	public int getShiftGroupInfoListCnt(HttpServletRequest request) ;
	
	public int checkShiftGroupInfo(HttpServletRequest request) ;
	
	public int addShiftGroupInfo(HttpServletRequest request) ;
	
	public int updateShiftGroupInfo(HttpServletRequest request) ;
	
	public int deleteShiftGroupInfo(HttpServletRequest request) ;
	
	public Object getShiftGroupInfo(HttpServletRequest request) ;
	
	public int deleteShiftGroupEmpInfo(HttpServletRequest request) ;
	
	public int addGroupEmpInfo(HttpServletRequest request) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getShiftGroupEmpInfoList(HttpServletRequest request) ;

	public int getShiftGroupEmpInfoListCnt(HttpServletRequest request) ;
	
	public int checkShiftGroupEmpDate(HttpServletRequest request) ;
}
