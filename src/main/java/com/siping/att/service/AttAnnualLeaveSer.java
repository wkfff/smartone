package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface AttAnnualLeaveSer {
	 
	public Object getAttAnnualLeaveInfo(HttpServletRequest request) ;
	/**
	 * 年休假信息
	 * @param request
	 * @return
	 */
    @SuppressWarnings({ "rawtypes" })
	public List getAttAnnualLeaveInfoList(HttpServletRequest request) ;
	/**
	 * 年休假信息
	 * @param request
	 * @return
	 */
	public int getAttAnnualLeaveInfoCnt(HttpServletRequest request) ;
	/**
	 * 年休假信息
	 * @param request
	 * @return
	 */
    @SuppressWarnings({ "rawtypes" })
	public List getEsslLeaveInfo(HttpServletRequest request) ;
	/**
	 * 年休假信息
	 * @param request
	 * @return
	 */
	public int getEsslLeaveInfoCnt(HttpServletRequest request) ;
	 
	public int deleteAttAnnualLeaveInfo(HttpServletRequest request) ;
	 
	public int updateAttAnnualLeaveInfo(HttpServletRequest request) ;
	 
	public int addAttAnnualLeaveInfo(HttpServletRequest request) ;
	 
	public int checkAddAttAnnualLeaveInfo(HttpServletRequest request) ;
	 
	public int createAttAnnualLeaveInfo(HttpServletRequest request) ;
	 
	public int createAttAnnualLeaveInfo() ;
}
