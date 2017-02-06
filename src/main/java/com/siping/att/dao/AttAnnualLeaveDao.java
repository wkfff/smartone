package com.siping.att.dao;

import java.util.List;

public interface AttAnnualLeaveDao {
	/**
	 * 年休假信息
	 * @param object
	 * @return
	 */
	public Object getAttAnnualLeaveInfo(Object object) ;
	/**
	 * 年休假信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAttAnnualLeaveInfoList(Object object) ;
	/**
	 * 年休假信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAttAnnualLeaveInfoList(Object object, int currentPage, int pageSize);
	/**
	 * 年休假信息 
	 * @param object
	 * @return
	 */
	public int getAttAnnualLeaveInfoCnt(Object object) ;
 
	/**
	 * 年休假信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEsslLeaveInfo(Object object) ;
	/**
	 * 年休假信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEsslLeaveInfo(Object object, int currentPage, int pageSize);
	/**
	 * 年休假信息 
	 * @param object
	 * @return
	 */
	public int getEsslLeaveInfoCnt(Object object) ;
	 
	public int deleteAttAnnualLeaveInfo(Object object) ;
	 
	@SuppressWarnings("rawtypes")
	public int updateAttAnnualLeaveInfo(List list) ;
	 
	public int addAttAnnualLeaveInfo(Object object) ;
	 
	public int checkAddAttAnnualLeaveInfo(Object object) ;
 
	public int createAttAnnualLeaveInfo(Object object) ;
}
