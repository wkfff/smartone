package com.siping.system.service.impl;

import java.util.ArrayList;
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
import com.siping.system.dao.SystemMgtDao; 
import com.siping.system.service.SystemMgtSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
 
@Service
public class SystemMgtSerImpl implements SystemMgtSer {
	
	Logger logger = Logger.getLogger(SystemMgtSerImpl.class);
	
	@Autowired
	private SystemMgtDao systemMgtDao;
	/**
	 * 获取职群信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getPostGroupInfo(HttpServletRequest request) {
		List retrunList = new ArrayList() ;
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = 
				systemMgtDao.getPostGroupInfo(paramMap , 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
						) ;
		}
		else{
			retrunList = systemMgtDao.getPostGroupInfo(paramMap) ;
		}
		
		return retrunList ; 
	}
	/**
	 * 获取职群信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getPostGroupInfoCnt(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		return systemMgtDao.getPostGroupInfoCnt(paramMap) ;
	} 
	/**
	 * 修改职群信息
	 */
	public int updatePostGroupInfo(HttpServletRequest request) {  
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap) ;
		
		this.systemMgtDao.updatePostGroupInfo(updateList);
		
		return 0;
	} 
	/**
	 * 删除职群信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deletePostGroupInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		
		this.systemMgtDao.deletePostGroupInfo(paramMap) ;
		
		return 0;
	}  
	/**
	 * 检查职群信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int checkPostGroupInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		  
		return this.systemMgtDao.checkPostGroupInfo(paramMap) ;
	}   
	/**
	 * 添加职群信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addPostGroupInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CREATED_BY", admin.getAdminID()) ;
		
		this.systemMgtDao.addPostGroupInfo(paramMap) ;
		
		return 0;
	} 
	/**
	 * 获取职列信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getPostColumnInfo(HttpServletRequest request) {
		List retrunList = new ArrayList() ;
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = 
				systemMgtDao.getPostColumnInfo(paramMap , 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
						) ;
		}
		else{
			retrunList = systemMgtDao.getPostColumnInfo(paramMap) ;
		}
		
		return retrunList ; 
	}
	/**
	 * 获取职列信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getPostColumnInfoCnt(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		return systemMgtDao.getPostColumnInfoCnt(paramMap) ;
	}  
	/**
	 * 修改职列信息
	 */
	public int updatePostColumnInfo(HttpServletRequest request) {  
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap) ;
		
		this.systemMgtDao.updatePostColumnInfo(updateList);
		
		return 0;
	} 
	/**
	 * 删除职列信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deletePostColumnInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		
		this.systemMgtDao.deletePostColumnInfo(paramMap) ;
		
		return 0;
	}  
	/**
	 * 检查职列信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int checkPostColumnInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		  
		return this.systemMgtDao.checkPostColumnInfo(paramMap) ;
	}   
	/**
	 * 添加职列信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addPostColumnInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CREATED_BY", admin.getAdminID()) ;
		
		this.systemMgtDao.addPostColumnInfo(paramMap) ;
		
		return 0;
	} 
	/**
	 * 获取职级信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getPostGradeInfo(HttpServletRequest request) {
		List retrunList = new ArrayList() ;
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = 
				systemMgtDao.getPostGradeInfo(paramMap , 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
						) ;
		}
		else{
			retrunList = systemMgtDao.getPostGradeInfo(paramMap) ;
		}
		
		return retrunList ; 
	}
	/**
	 * 获取职级信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getPostGradeInfoCnt(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		return systemMgtDao.getPostGradeInfoCnt(paramMap) ;
	}  
	/**
	 * 修改职级信息
	 */
	public int updatePostGradeInfo(HttpServletRequest request) {  
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap) ;
		
		this.systemMgtDao.updatePostGradeInfo(updateList);
		
		return 0;
	} 
	/**
	 * 删除职级信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deletePostGradeInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		
		this.systemMgtDao.deletePostGradeInfo(paramMap) ;
		
		return 0;
	}  
	/**
	 * 检查职级信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int checkPostGradeInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		  
		return this.systemMgtDao.checkPostGradeInfo(paramMap) ;
	}   
	/**
	 * 添加职级信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addPostGradeInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CREATED_BY", admin.getAdminID()) ;
		
		this.systemMgtDao.addPostGradeInfo(paramMap) ;
		
		return 0;
	} 
	/**
	 * 获取职位岗位信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getPostInfo(HttpServletRequest request) {
		List retrunList = new ArrayList() ;
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = 
				systemMgtDao.getPostInfo(paramMap , 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
						) ;
		}
		else{
			retrunList = systemMgtDao.getPostInfo(paramMap) ;
		}
		
		return retrunList ; 
	}
	/**
	 * 获取职位岗位信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getPostInfoCnt(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		return systemMgtDao.getPostInfoCnt(paramMap) ;
	}  
	/**
	 * 修改职位岗位信息
	 */
	public int updatePostInfo(HttpServletRequest request) {  
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap) ;
		
		this.systemMgtDao.updatePostInfo(updateList);
		
		return 0;
	} 
	/**
	 * 删除职位岗位信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deletePostInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		
		this.systemMgtDao.deletePostInfo(paramMap) ;
		
		return 0;
	}  
	/**
	 * 检查职位岗位信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int checkPostInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		  
		return this.systemMgtDao.checkPostInfo(paramMap) ;
	}   
	/**
	 * 添加职位岗位信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addPostInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CREATED_BY", admin.getAdminID()) ;
		
		this.systemMgtDao.addPostInfo(paramMap) ;
		
		return 0;
	}   
	/**
	 * 获取职务信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getPositionInfo(HttpServletRequest request) {
		List retrunList = new ArrayList() ;
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = 
				systemMgtDao.getPositionInfo(paramMap , 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
						) ;
		}
		else{
			retrunList = systemMgtDao.getPositionInfo(paramMap) ;
		}
		
		return retrunList ; 
	}
	/**
	 * 获取职务信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getPositionInfoCnt(HttpServletRequest request) {
		
		Map paramMap = new LinkedHashMap() ;
		paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		paramMap.put("language",Messages.getLanguage(request));
		return systemMgtDao.getPositionInfoCnt(paramMap) ;
	}  
	/**
	 * 修改职务信息
	 */
	public int updatePositionInfo(HttpServletRequest request) {  
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap) ;
		
		this.systemMgtDao.updatePositionInfo(updateList);
		
		return 0;
	} 
	/**
	 * 删除职务信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deletePositionInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ; 
		
		this.systemMgtDao.deletePositionInfo(paramMap) ;
		
		return 0;
	}  
	/**
	 * 检查职务信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int checkPositionInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		  
		return this.systemMgtDao.checkPositionInfo(paramMap) ;
	}   
	/**
	 * 添加职务信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addPositionInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CREATED_BY", admin.getAdminID()) ;
		
		this.systemMgtDao.addPositionInfo(paramMap) ;
		
		return 0;
	}  
}
