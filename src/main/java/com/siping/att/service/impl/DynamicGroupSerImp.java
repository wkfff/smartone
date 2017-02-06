package com.siping.att.service.impl;

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

import com.siping.att.dao.DynamicGroupDao;
import com.siping.att.service.DynamicGroupSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class DynamicGroupSerImp implements DynamicGroupSer {

	Logger logger = Logger.getLogger(DynamicGroupSerImp.class);

	@Autowired
	private DynamicGroupDao dynamicGroupDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getDynamicGroup(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		return this.dynamicGroupDao.getDynamicGroup(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getDynamicGroupSelectionList(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunList = dynamicGroupDao.getDynamicGroupSelectionList(paramMap);
		
		return retrunList;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getDynamicGroupList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.dynamicGroupDao.getDynamicGroupList(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.dynamicGroupDao.getDynamicGroupList(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getDynamicGroupCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.dynamicGroupDao.getDynamicGroupCnt(paramMap);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.att.service.DynamicGroupSer#addDynamicGroupInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	public int addDynamicGroupInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);

		return this.dynamicGroupDao.addDynamicGroupInfo(insertList);
 
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.att.service.DynamicGroupSer#updateDynamicGroupInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	public int updateDynamicGroupInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);

		return this.dynamicGroupDao.updateDynamicGroupInfo(updateList);
 
	}

	@SuppressWarnings({ "rawtypes" })
	public int deleteDynamicGroupInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		this.dynamicGroupDao.deleteDynamicGroupInfo(paramMap);

		return 0;
	}

	@SuppressWarnings({ "rawtypes" })
	public List getDeptList(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return dynamicGroupDao.getLoginUserDeptList(paramMap);

	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getDynamicGroupEmpInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.dynamicGroupDao.getDynamicGroupEmpInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.dynamicGroupDao.getDynamicGroupEmpInfo(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes" })
	public int getDynamicGroupEmpInfoCnt(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.dynamicGroupDao.getDynamicGroupEmpInfoCnt(paramMap);
	}
 
	public int addDynamicGroupEmpInfo(HttpServletRequest request) { 

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		
		this.dynamicGroupDao.addDynamicGroupEmpInfo(insertList);

		return 0;
	}

	public int deleteDynamicGroupEmpInfo(HttpServletRequest request) {
		

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> deleteList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		
		return dynamicGroupDao.deleteDynamicGroupEmpInfo(deleteList);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getNonDynamicGroupEmpInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.dynamicGroupDao.getNonDynamicGroupEmpInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.dynamicGroupDao.getNonDynamicGroupEmpInfo(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getNonDynamicGroupEmpInfoCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());

		return this.dynamicGroupDao.getNonDynamicGroupEmpInfoCnt(paramMap);
	}

}
