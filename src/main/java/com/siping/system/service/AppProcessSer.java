package com.siping.system.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface AppProcessSer { 
	/**
	 * 获取个人流程信息
	 * @param request
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getAppProcessPInfo(HttpServletRequest request) ;
	/**
	 * 获取流程信息
	 * @param request
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getAppProcessInfo(HttpServletRequest request) ;
	/**
	 *  获取个人流程信息
	 * @param request
	 * @return
	 */  
	public int getAppProcessPInfoCnt(HttpServletRequest request) ;
	/**
	 * 获取个人流程信息
	 * @param request
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getAppProcessPAInfo(HttpServletRequest request) ;
	/**
	 * 获取部门流程信息
	 * @param request
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getAppProcessDAInfo(HttpServletRequest request) ;
	/**
	 *  获取部门流程信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAppProcessDInfo(HttpServletRequest request) ;
	/**
	 * 获取部门流程信息
	 * @param request
	 * @return
	 */  
	public int getAppProcessDInfoCnt(HttpServletRequest request) ;
	/**
	 * 获取个人流程信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getAppProcessPInfoObj(HttpServletRequest request) ;
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	/**
	 * 获取部门流程信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getAppProcessDInfoObj(HttpServletRequest request) ; 
	/**
	 *添加个人流程信息
	 * @param request
	 * @return
	 */
	public int addAppProcessPInfo(HttpServletRequest request) ;
	/**
	 * 添加部门流程信息 
	 * @param request
	 * @return
	 */
	public int addAppProcessDInfo(HttpServletRequest request) ;
	/**
	 * 修改个人流程信息
	 * @param request
	 * @return
	 */  
	public int updateAppProcessPInfo(HttpServletRequest request) ;
	/**
	 * 修改部门流程信息 
	 * @param request
	 * @return
	 */  
	public int updateAppProcessDInfo(HttpServletRequest request) ;
	/**
	 * 删除个人流程信息
	 * @param request
	 * @return
	 */ 
	public int deleteAppProcessPInfo(HttpServletRequest request) ;
	/**
	 * 删除部门流程信息 
	 * @param request
	 * @return
	 */ 
	public int deleteAppProcessDInfo(HttpServletRequest request) ;
	
	@SuppressWarnings("rawtypes")
	public List getSendEmailInfo(HttpServletRequest request);
	public int getSendEmailInfoCnt(HttpServletRequest request);
	
	public String updateSendEmailInfo(HttpServletRequest request) throws SQLException;
	public String addSendEmailInfo(HttpServletRequest request) throws SQLException;
	public String deleteSendEmailInfo(HttpServletRequest request) throws SQLException;
	 
}
