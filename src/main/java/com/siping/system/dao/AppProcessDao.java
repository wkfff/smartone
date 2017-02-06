package com.siping.system.dao;
 
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface AppProcessDao {
	/**
	 * 获取个人流程信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public Map getAppProcessPInfoObj(Object obj) ; 
	/**
	 * 获取个人流程信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getAppProcessPInfo(Object obj) ;
	/**
	 * 获取个人流程信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getAppProcessInfo(Object obj) ;
	/**
	 * 获取个人流程信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getAppProcessPInfo(Object object, int currentPage, int pageSize);
	/**
	 * 获取个人流程信息
	 * @param object 
	 * @return
	 */ 
	public int getAppProcessPInfoCnt(Object object);
	/**
	 * 获取个人流程信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public Map getAppProcessPAInfoObj(Object obj) ; 
	/**
	 * 获取个人流程信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getAppProcessPAInfo(Object obj) ;
	/**
	 * 获取部门流程信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getAppProcessDAInfo(Object obj) ; 
	/**
	 * 获取部门流程信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public Map getAppProcessDInfoObj(Object obj) ;
	/**
	 * 获取部门流程信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getAppProcessDInfo(Object obj) ;
	/**
	 * 获取部门流程信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getAppProcessDInfo(Object object, int currentPage, int pageSize);
	/**
	 * 获取部门流程信息
	 * @param object 
	 * @return
	 */ 
	public int getAppProcessDInfoCnt(Object object);
	
	/**
	 * 添加个人流程信息
	 * @param object
	 * @return
	 */ 
	public int addAppProcessPInfo(Object object); 
	/**
	 * 添加个人流程信息
	 * @param object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int addAppProcessPInfo(List object); 
	/**
	 * 添加部门流程信息
	 * @param object
	 * @return
	 */ 
	public int addAppProcessDInfo(Object object); 
	/**
	 * 添加部门流程信息
	 * @param object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int addAppProcessDInfo(List object); 
	 
	/**
	 * 修改个人流程信息
	 * @param object
	 * @return
	 */  
	public int updateAppProcessPInfo(Object object); 
	/**
	 * 修改个人流程信息
	 * @param object
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public int updateAppProcessPInfo(List object); 
	/**
	 * 修改部门流程信息
	 * @param object
	 * @return
	 */  
	public int updateAppProcessDInfo(Object object); 
	/**
	 * 修改部门流程信息
	 * @param object
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public int updateAppProcessDInfo(List object); 
	 
	/**
	 * 删除个人流程信息
	 * @param object
	 * @return
	 */ 
	public int deleteAppProcessPInfo(Object object); 
	 
	/**
	 * 删除个人流程信息
	 * @param object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int deleteAppProcessPInfo(List object); 
	/**
	 * 删除部门流程信息
	 * @param object
	 * @return
	 */ 
	public int deleteAppProcessDInfo(Object object); 
	 
	/**
	 * 删除部门流程信息
	 * @param object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int deleteAppProcessDInfo(List object); 
	
	@SuppressWarnings("rawtypes")
	public List getSendEmailInfo(Object object);
	public int getSendEmailInfoCnt(Object object);
	
	public void updateSendEmailInfo(Object object) throws SQLException;
	public void addSendEmailInfo(Object object) throws SQLException;  
	public void deleteSendEmailInfo(Object object) throws SQLException;
}
