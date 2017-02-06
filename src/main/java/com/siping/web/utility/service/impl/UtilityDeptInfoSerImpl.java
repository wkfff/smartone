package com.siping.web.utility.service.impl;

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
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.dao.UtilityDeptInfoDao; 
import com.siping.web.utility.service.UtilityDeptInfoSer;

@Service
public class UtilityDeptInfoSerImpl implements UtilityDeptInfoSer {

	Logger logger = Logger.getLogger(UtilityDeptInfoSerImpl.class);

	@Autowired
	private UtilityDeptInfoDao utilityDeptInfoDao;

	/*
	 * (non-Javadoc) 
	 * @see
	 * com.siping.web.utility.service.UtilitySer#getDeptSelectList(javax
	 * .servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List getDeptSelectList(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		Object cpnyID = paramMap.get("CPNY_ID");
		if(cpnyID==null||cpnyID.equals("")){
			paramMap.put("CPNY_ID", admin.getCpnyId()); 
		} 
		return this.utilityDeptInfoDao.getDeptSelectList(paramMap);
	}  
	/*
	 * (non-Javadoc) 
	 * @see
	 * com.siping.web.utility.service.UtilitySer#getDeptSelectList(javax
	 * .servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List getDeptTreeInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		Object cpnyID = paramMap.get("CPNY_ID");
		if(cpnyID==null||cpnyID.equals("")){
			paramMap.put("CPNY_ID", admin.getCpnyId()); 
		} 

		return this.utilityDeptInfoDao.getDeptTreeInfo(paramMap);
	}  
	
	/**
	 * 部门信息
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getDepartmentInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		Object cpnyID = paramMap.get("CPNY_ID");
		if(cpnyID==null||cpnyID.equals("")){
			paramMap.put("CPNY_ID", admin.getCpnyId()); 
		} 
		 
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.utilityDeptInfoDao.getDepartmentInfoList(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.utilityDeptInfoDao.getDepartmentInfoList(paramMap);
		}

		return retrunList;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getDepartmentInfoListCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		Object cpnyID = paramMap.get("CPNY_ID");
		if(cpnyID==null||cpnyID.equals("")){
			paramMap.put("CPNY_ID", admin.getCpnyId()); 
		} 
		 
		return this.utilityDeptInfoDao.getDepartmentInfoListCnt(paramMap);
	} 
} 
