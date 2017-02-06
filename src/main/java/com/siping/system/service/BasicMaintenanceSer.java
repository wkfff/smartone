package com.siping.system.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface BasicMaintenanceSer {
	
	/**
	 * 获取部门信息
	 */
	@SuppressWarnings("rawtypes")
	public List getDeptInfoList(HttpServletRequest request);  
	/**
	 * 根据父级部门获取子级部门信息
	 */
	@SuppressWarnings("rawtypes")
	public List getDeptListByParentCode(HttpServletRequest request) ;
	
	/**
	 * 获取父级CODE信息
	 */
	@SuppressWarnings("rawtypes")
	public List getParentCodeList(HttpServletRequest request);
	
	/**
	 * 获取分类父级CODE信息
	 */
	@SuppressWarnings("rawtypes")
	public List getTypeParentCodeList(HttpServletRequest request);
	/**
	 * 根据父级CODE获取子级CODE信息
	 */
	@SuppressWarnings("rawtypes")
	public List getCodeListByParentCode(HttpServletRequest request) ;
	/**
	 * 增加CODE信息 
	 * @throws SQLException 
	 */ 
	public int addCodeInfo(HttpServletRequest request) throws SQLException ;
	/**
	 * 修改CODE信息
	 * @throws SQLException 
	 */
	public int updateCodeInfo(HttpServletRequest request) throws SQLException ;  
	/**
	 * 删除CODE信息
	 * @throws SQLException 
	 */
	public int deleteCodeInfo(HttpServletRequest request) throws SQLException ;
	/**
	 * 获取CODE列表
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getActivitySelectMap(HttpServletRequest request) ; 

	/**
	 * 获取CODE列表
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getSysCodeSelectMap(HttpServletRequest request) ;
	/**
	 * 获取CODE列表
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getSysCodeSelectList(HttpServletRequest request) ;

	/**
	 * 获取CODE列表
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getCompanySelectMap(HttpServletRequest request) ; 
	/**
	 * 获取部门等级列表
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDeptLevelList(HttpServletRequest request) ;
	 
	/**
	 * 获取公司信息
	 */
	@SuppressWarnings("rawtypes")
	public List getCompanyInfo(HttpServletRequest request); 
	/**
	 * 获取公司信息
	 */ 
	public Object getCompanyInfoObj(HttpServletRequest request); 
	/**
	 * 修改公司信息
	 */
	public int updateCompanyInfo(HttpServletRequest request) ;
	/**
	 * 删除公司信息
	 */
	public int deleteCompanyInfo(HttpServletRequest request) ;
	
	/**
	 * 检查公司信息
	 */
	public int checkCompanyInfo(HttpServletRequest request) ;  
	/**
	 * 添加公司信息
	 */
	public int addCompanyInfo(HttpServletRequest request) ;  
	
	/**
	 * 获取父级菜单信息
	 */
	@SuppressWarnings("rawtypes")
	public List getParentMenuList(HttpServletRequest request);
	/**
	 * 根据父级菜单获取子级菜单信息
	 */
	@SuppressWarnings("rawtypes")
	public List getMenuListByParentMenuCode(HttpServletRequest request) ;
	
	public String getMenuInfo(HttpServletRequest request) ;
	/**
	/**getMenuInfo
	 * 增加菜单信息
	 */
	public int addMenuInfo(HttpServletRequest request) ;
	/**
	 * 修改菜单信息
	 */
	public int updateMenuInfo(HttpServletRequest request) ; 
	/**
	 * 删除菜单信息
	 */
	public int deleteMenuInfo(HttpServletRequest request) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getAnnouncementList(HttpServletRequest request);
	public int getAnnouncementListCnt(HttpServletRequest request);
	public void transferAnnouncement(HttpServletRequest request) throws SQLException;
	public String removeAnnouncement(HttpServletRequest request) throws SQLException;
	
	/**
	 * 获取分类信息
	 */
	@SuppressWarnings("rawtypes")
	public List getCategoryList(HttpServletRequest request);
	public int getCategoryListCnt(HttpServletRequest request);
	/**
	 * 获取分类属性
	 */
	@SuppressWarnings("rawtypes")
	public List getPropertyList(HttpServletRequest request);
	public int getPropertyListCnt(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getPropertyValueList(HttpServletRequest request);
	public int getPropertyValueListCnt(HttpServletRequest request);
	
	public String addPropertyToCategory(HttpServletRequest request);
	
	public String deletePropertyFromCategory(HttpServletRequest request);
	
	public String addValueToProperty(HttpServletRequest request);
	
	public String deleteValueFromProperty(HttpServletRequest request);
	
	public String updateCategory(HttpServletRequest request);
	
	public String updateProperty(HttpServletRequest request);
	
	public String updatePropertyValue(HttpServletRequest request);
	
	public String addCategoryInfo(HttpServletRequest request);
	
	public int checkCategoryId(HttpServletRequest request);
	
	public int checkCategoryDelete(HttpServletRequest request);
	
	public String addPropertyInfo(HttpServletRequest request);
	
	public int checkPropertyId(HttpServletRequest request);
	
	public String deleteCategoryInfo(HttpServletRequest request);
	
	public String deletePropertyInfo(HttpServletRequest request);
	
	public String deletePropertyValueInfo(HttpServletRequest request);
	
	public String addPropertyValueInfo(HttpServletRequest request);
	
	public int checkPropertyValueId(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getStorageWarnList(HttpServletRequest request);
	public int getStorageWarnListCnt(HttpServletRequest request);
	
	public String addStorageWarnTarget(HttpServletRequest request);
	
	public int checkAddStorageWarnTarget(HttpServletRequest request);
	
	public String deleteStorageWarnTarget(HttpServletRequest request);
}
