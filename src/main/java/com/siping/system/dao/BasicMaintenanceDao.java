package com.siping.system.dao;

import java.sql.SQLException;
import java.util.List; 
import java.util.Map;

public interface BasicMaintenanceDao {
	/**
	 * 获取部门信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptInfoList(Object object); 
	/**
	 * 根据父级部门获取子级部门信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptListByParentCode(Object object);
	/**
	 * 获取父级CODE信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getParentCodeList(Object object);
	/**
	 * 获取父级CODE信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getTypeParentCodeList(Object object);
	/**
	 * 根据父级CODE获取子级CODE信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getCodeListByParentCode(Object object);
	/**
	 * 增加CODE信息 
	 */ 
	public int addCodeInfo(Object object);
	/**
	 * 增加CODE信息 
	 * @throws SQLException 
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public int addCodeInfo(List object) throws SQLException;
	/**
	 * 修改CODE信息
	 */
	public int updateCodeInfo(Object object);
	/**
	 * 修改CODE信息
	 * @throws SQLException 
	 */
	@SuppressWarnings({ "rawtypes" })
	public int updateCodeInfo(List object) throws SQLException; 
	/**
	 * 删除CODE信息
	 * @throws SQLException 
	 */
	public int deleteCodeInfo(Object object) throws SQLException; 
	/**
	 * 删除CODE信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deleteCodeInfo(List object);
	/**
	 * 获得下拉列表
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public Map getSysCodeSelectMap(Object object);
	/**
	 * 获得下拉列表
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getSysCodeSelectList(Object object);
	/**
	 * 获得下拉列表
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public Map getActivitySelectMap(Object object);
	/**
	 * 获取公司列表
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public Map getCompanySelectMap(Object object);
	/**
	 * 获取部门等级列表
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptLevelList(Object object);
	
	/**
	 * 获得公司信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getCompanyInfo(Object object);
	/**
	 * 获得公司信息
	 * @param object
	 * @return
	 */ 
	public Object getCompanyInfoObj(Object object);
	/**
	 * 修改公司信息
	 * @param object
	 * @return
	 */ 
	public int updateCompanyInfo(Object object);
	/**
	 * 修改公司信息
	 * @param object
	 * @return
	 */ 
	public int deleteCompanyInfo(Object object);
	
	/**
	 * 检查公司信息
	 * @param object
	 * @return
	 */ 
	public int checkCompanyInfo(Object object);
	/**
	 * 添加公司信息
	 * @param object
	 * @return
	 */ 
	public int addCompanyInfo(Object object);
	/**
	 * 获取父级菜单信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getParentMenuList(Object object);
	/**
	 * 根据父级菜单获取子级菜单信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getMenuListByParentMenuCode(Object object);
	
	public String getMenuInfo(Object object);
	/**
	 * 增加菜单信息
	 */
	public int addMenuInfo(Object object);
	/**
	 * 增加菜单信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int addMenuInfo(List object);
	/**
	 * 修改菜单信息
	 */
	public int updateMenuInfo(Object object); 
	/**
	 * 修改菜单信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int updateMenuInfo(List object);
	/**
	 * 删除菜单信息
	 */
	public int deleteMenuInfo(Object object);
	/**
	 * 删除菜单信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deleteMenuInfo(List object);
	
	
	@SuppressWarnings("rawtypes")
	List getAnnouncementList(Object obj);

	int getAnnouncementListCnt(Object obj);

	@SuppressWarnings("rawtypes")
	void addAnnouncement(List obj) throws SQLException;

	void removeAnnouncement(Object obj) throws SQLException;

	@SuppressWarnings("rawtypes")
	void updateAnnouncement(List obj) throws SQLException;
	
	@SuppressWarnings({ "rawtypes" })
	public List getCategoryList(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getCategoryList(Object object,int currentPage,int pageSize);
	public int getCategoryListCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getPropertyList(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getPropertyList(Object object,int currentPage,int pageSize);
	public int getPropertyListCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getPropertyValueList(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getPropertyValueList(Object object,int currentPage,int pageSize);
	public int getPropertyValueListCnt(Object object);
	
	@SuppressWarnings("rawtypes") 
	public String addPropertyToCategory(List object);
	@SuppressWarnings("rawtypes")
	public String deletePropertyFromCategory(List object);
	
	@SuppressWarnings("rawtypes") 
	public String addValueToProperty(List object);
	@SuppressWarnings("rawtypes")
	public String deleteValueFromProperty(List object);
	
	@SuppressWarnings("rawtypes")
	public String updateCategory(List objlist) ;
	
	@SuppressWarnings("rawtypes")
	public String updateProperty(List objlist) ;
	
	@SuppressWarnings("rawtypes")
	public String updatePropertyValue(List objlist) ;
	
	public String addCategoryInfo(Object obj) ;
	
	public int checkCategoryId(Object obj);
	
	public int checkCategoryDelete(Object obj);
	
	public String addPropertyInfo(Object obj) ;
	
	public int checkPropertyId(Object obj);
	
	public String deleteCategoryInfo(Object obj) ;
	
	public String deletePropertyInfo(Object obj) ;
	
	public String deletePropertyValueInfo(Object obj) ;
	
	public String addPropertyValueInfo(Object obj) ;
	
	public int checkPropertyValueId(Object obj);
	
	@SuppressWarnings({ "rawtypes" })
	public List getStorageWarnList(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getStorageWarnList(Object object,int currentPage,int pageSize);
	public int getStorageWarnListCnt(Object object);
	
	public String addStorageWarnTarget(Object obj) ;
	
	public int checkAddStorageWarnTarget(Object obj);
	
	public String deleteStorageWarnTarget(Object obj) ;
}
