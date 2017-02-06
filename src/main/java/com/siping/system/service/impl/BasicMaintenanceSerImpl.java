package com.siping.system.service.impl;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest; 

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.system.bean.AdminBean;
import com.siping.system.dao.BasicMaintenanceDao;
import com.siping.system.service.BasicMaintenanceSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
 
@Service
public class BasicMaintenanceSerImpl implements BasicMaintenanceSer {
	
	Logger logger = Logger.getLogger(BasicMaintenanceSerImpl.class);
	
	@Autowired
	private BasicMaintenanceDao basicMaintenanceDao;
	/**
	 * 获取公司信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getCompanyInfo(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		paramMap.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getCompanyInfo(paramMap) ;
	} 
	/**
	 * 获取公司信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public Object getCompanyInfoObj(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		// 页面提交数据
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		return this.basicMaintenanceDao.getCompanyInfoObj(paramMap) ;
	}
	//@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int updateCompanyInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		this.basicMaintenanceDao.updateCompanyInfo(paramMap) ;
		
		return 0;
	} 
	//@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int deleteCompanyInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		this.basicMaintenanceDao.deleteCompanyInfo(paramMap) ;
		
		return 0;
	}  
	//@Override
	@SuppressWarnings({ "rawtypes" })
	public int checkCompanyInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		  
		return this.basicMaintenanceDao.checkCompanyInfo(paramMap) ;
	}  
	//@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addCompanyInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CREATED_BY", admin.getAdminID()) ;
		
		this.basicMaintenanceDao.addCompanyInfo(paramMap) ;
		
		return 0;
	}   
	/**
	 * 获取部门信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getDeptInfoList(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = new LinkedHashMap() ;
		paramMap.put("language",Messages.getLanguage(request));
		paramMap.put("parentCode",admin.getCpnyId());
		return this.basicMaintenanceDao.getDeptInfoList(paramMap) ;
	} 
	/**
	 * 根据父级部门获取子级部门信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptListByParentCode(HttpServletRequest request) {
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		
		return this.basicMaintenanceDao.getDeptListByParentCode(paramMap) ;
	}
	/**
	 * 获取父级CODE信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getParentCodeList(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		paramMap.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getParentCodeList(paramMap) ;
	}
	
	/**
	 * 获取父级CODE信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getTypeParentCodeList(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		paramMap.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getTypeParentCodeList(paramMap) ;
	}
	/**
	 * 根据父级CODE获取子级CODE信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getCodeListByParentCode(HttpServletRequest request) {
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getCodeListByParentCode(paramMap) ;
	}
	/**
	 * 增加CODE信息 
	 */
	public int addCodeInfo(HttpServletRequest request) throws SQLException {
		 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("PARENT_CODE", request.getParameter("parentCode")) ;
		appendMap.put("CREATED_BY", admin.getAdminID()) ;
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap) ;
		
		this.basicMaintenanceDao.addCodeInfo(insertList) ;
		
		return 0 ;
	}
	/**
	 * 修改CODE信息
	 */
	public int updateCodeInfo(HttpServletRequest request) throws SQLException {
		 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("PARENT_CODE", request.getParameter("parentCode")) ;
		appendMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap) ;
		
		this.basicMaintenanceDao.updateCodeInfo(updateList) ;
		
		return 0 ;
	}
	/**
	 * 删除CODE信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deleteCodeInfo(HttpServletRequest request) throws SQLException {
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		this.basicMaintenanceDao.deleteCodeInfo(paramMap) ;
		
		return 0 ;
	}
	/**
	 * 获取父级菜单信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getParentMenuList(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		paramMap.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getParentMenuList(paramMap) ;
	}
	/**
	 * 根据父级菜单获取子级菜单信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getMenuListByParentMenuCode(HttpServletRequest request) {
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request)); 
		return this.basicMaintenanceDao.getMenuListByParentMenuCode(paramMap) ;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getMenuInfo(HttpServletRequest request) {
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request)); 
		return this.basicMaintenanceDao.getMenuInfo(paramMap) ;
	}
	
	/**
	 * 增加菜单信息
	 */
	public int addMenuInfo(HttpServletRequest request) {
		 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("PARENT_MENU_CODE", request.getParameter("parentCode")) ;
		appendMap.put("CREATED_BY", admin.getAdminID()) ;
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap) ;
		
		this.basicMaintenanceDao.addMenuInfo(insertList) ;
		
		return 0 ;
	} 
	/**
	 * 修改菜单信息
	 */
	public int updateMenuInfo(HttpServletRequest request) {
		 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("PARENT_MENU_CODE", request.getParameter("parentCode")) ;
		appendMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap) ;
		
		this.basicMaintenanceDao.updateMenuInfo(updateList) ;
		
		return 0 ;
	}
	/**
	 * 删除菜单信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deleteMenuInfo(HttpServletRequest request) {

		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		
		this.basicMaintenanceDao.deleteMenuInfo(paramMap) ;
		
		return 0 ;
	} 
	/**
	 * 获取CODE使用状态信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getActivitySelectMap(HttpServletRequest request){ 
		Map param = new LinkedHashMap();
		param.put("PARENTCODE", "");  
		param.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getActivitySelectMap(param);		
	} 
	/**
	 * 获取CODE使用状态信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getSysCodeSelectMap(HttpServletRequest request){  
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		LinkedHashMap param = ObjectBindUtil.getRequestParamData(request) ;  
		param.put("language",Messages.getLanguage(request));
		param.put("CPNY_ID", admin.getCpnyId()); 
		return this.basicMaintenanceDao.getSysCodeSelectMap(param);		
	}
	/**
	 * 获取CODE使用状态信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getSysCodeSelectList(HttpServletRequest request){ 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		LinkedHashMap param = ObjectBindUtil.getRequestParamData(request) ;
		param.put("language",Messages.getLanguage(request));
		param.put("CPNY_ID", admin.getCpnyId()); 
		return this.basicMaintenanceDao.getSysCodeSelectList(param);		
	}
	/**
	 * 获取CODE使用状态信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getCompanySelectMap(HttpServletRequest request){ 
		Map param = new LinkedHashMap(); 
		param.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getCompanySelectMap(param);		
	}
	/**
	 * 获取部门等级列表
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getDeptLevelList(HttpServletRequest request){ 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map param = new LinkedHashMap(); 
		param.put("CPNY_ID",admin.getCpnyId());
		param.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getDeptLevelList(param);		
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked"})
	@Override
	public List getAnnouncementList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("ADMIN_ID", admin.getAdminID());
		return this.basicMaintenanceDao.getAnnouncementList(paramMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked" })
	@Override
	public int getAnnouncementListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("EMP_ID", admin.getAdminID());
		return this.basicMaintenanceDao.getAnnouncementListCnt(paramMap);
	}
	
	@Override
	public void transferAnnouncement(HttpServletRequest request) throws SQLException{
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);
		if (insertList.size() > 0) {
			this.basicMaintenanceDao.addAnnouncement(insertList);
		}
		if (updateList.size() > 0) {
			this.basicMaintenanceDao.updateAnnouncement(updateList);
		}
	}
	
	@SuppressWarnings({"rawtypes","unchecked"})
	@Override
	public String removeAnnouncement(HttpServletRequest request) throws SQLException {
		String resultStr = "Y";
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		this.basicMaintenanceDao.removeAnnouncement(paramMap);
		return resultStr;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getCategoryList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language",Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			return this.basicMaintenanceDao.getCategoryList(paramMap,NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
		}else{
			return this.basicMaintenanceDao.getCategoryList(paramMap) ;
		}
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getCategoryListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getCategoryListCnt(paramMap) ;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getPropertyList(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			return this.basicMaintenanceDao.getPropertyList(paramMap,NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
		}else{
			return this.basicMaintenanceDao.getPropertyList(paramMap) ;
		}
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getPropertyListCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getPropertyListCnt(paramMap) ;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getPropertyValueList(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			return this.basicMaintenanceDao.getPropertyValueList(paramMap,NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
		}else{
			return this.basicMaintenanceDao.getPropertyValueList(paramMap) ;
		}
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getPropertyValueListCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getPropertyValueListCnt(paramMap) ;
	}
	
	@Override
	public String addPropertyToCategory(HttpServletRequest request) {
		String result = "Y";
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 

		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		String jsonString = request.getParameter("jsonData");
		
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);
		
		result = this.basicMaintenanceDao.addPropertyToCategory(insertList);
		return result;
	}
	@Override
	public String deletePropertyFromCategory(HttpServletRequest request) {
		String result = "Y";
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		String jsonString = request.getParameter("jsonData");
		
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);
		
		result = this.basicMaintenanceDao.deletePropertyFromCategory(insertList);
		return result;
	}
	
	@Override
	public String addValueToProperty(HttpServletRequest request) {
		String result = "Y";
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 

		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		String jsonString = request.getParameter("jsonData");
		
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);
		
		result = this.basicMaintenanceDao.addValueToProperty(insertList);
		return result;
	}
	@Override
	public String deleteValueFromProperty(HttpServletRequest request) {
		String result = "Y";
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		String jsonString = request.getParameter("jsonData");
		
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);
		
		result = this.basicMaintenanceDao.deleteValueFromProperty(insertList);
		return result;
	}
	
	@Override
	public String updateCategory(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);

		return this.basicMaintenanceDao.updateCategory(updateList);
	}
	@Override
	public String updateProperty(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);

		return this.basicMaintenanceDao.updateProperty(updateList);
	}
	@Override
	public String updatePropertyValue(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);

		return this.basicMaintenanceDao.updatePropertyValue(updateList);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String addCategoryInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));

		return this.basicMaintenanceDao.addCategoryInfo(paramMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int checkCategoryId(HttpServletRequest request) {
		int temp = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		temp  = this.basicMaintenanceDao.checkCategoryId(paramMap);

		return temp;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int checkCategoryDelete(HttpServletRequest request) {
		int temp = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		temp  = this.basicMaintenanceDao.checkCategoryDelete(paramMap);

		return temp;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String addPropertyInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));

		return this.basicMaintenanceDao.addPropertyInfo(paramMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int checkPropertyId(HttpServletRequest request) {
		int temp = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		temp  = this.basicMaintenanceDao.checkPropertyId(paramMap);

		return temp;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String deleteCategoryInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.basicMaintenanceDao.deleteCategoryInfo(paramMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String deletePropertyInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.basicMaintenanceDao.deletePropertyInfo(paramMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String deletePropertyValueInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.basicMaintenanceDao.deletePropertyValueInfo(paramMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String addPropertyValueInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));

		return this.basicMaintenanceDao.addPropertyValueInfo(paramMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int checkPropertyValueId(HttpServletRequest request) {
		int temp = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		temp  = this.basicMaintenanceDao.checkPropertyValueId(paramMap);

		return temp;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getStorageWarnList(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			return this.basicMaintenanceDao.getStorageWarnList(paramMap,NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
		}else{
			return this.basicMaintenanceDao.getStorageWarnList(paramMap) ;
		}
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getStorageWarnListCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		return this.basicMaintenanceDao.getStorageWarnListCnt(paramMap) ;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String addStorageWarnTarget(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));

		return this.basicMaintenanceDao.addStorageWarnTarget(paramMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int checkAddStorageWarnTarget(HttpServletRequest request) {
		int temp = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));
		temp  = this.basicMaintenanceDao.checkAddStorageWarnTarget(paramMap);

		return temp;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String deleteStorageWarnTarget(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language",Messages.getLanguage(request));

		return this.basicMaintenanceDao.deleteStorageWarnTarget(paramMap);
	}
}
