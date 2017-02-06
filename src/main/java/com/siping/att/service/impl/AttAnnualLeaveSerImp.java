package com.siping.att.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttAnnualLeaveDao;
import com.siping.att.service.AttAnnualLeaveSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttAnnualLeaveSerImp implements AttAnnualLeaveSer {
	Logger logger = Logger.getLogger(AttAnnualLeaveSerImp.class);

	@Autowired
	private AttAnnualLeaveDao attAnnualLeaveDao;

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see
	 * com.siping.att.service.AttAnnualLeaveSer#getAttAnnualLeaveInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings("rawtypes")
	public Object getAttAnnualLeaveInfo(HttpServletRequest request) {
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.attAnnualLeaveDao.getAttAnnualLeaveInfo(paramMap);
	}

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see
	 * com.siping.att.service.AttAnnualLeaveSer#getAttAnnualLeaveList(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings("rawtypes")
	public List getAttAnnualLeaveInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();

		// 页面提交数据
		LinkedHashMap paramMap = this.setGetAttAnnualLeaveParam(request);

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = attAnnualLeaveDao.getAttAnnualLeaveInfoList(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = attAnnualLeaveDao.getAttAnnualLeaveInfoList(paramMap);
		}

		return retrunList;
	}

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see
	 * com.siping.att.service.AttAnnualLeaveSer#getAttAnnualLeaveCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@SuppressWarnings("rawtypes")
	public int getAttAnnualLeaveInfoCnt(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = this.setGetAttAnnualLeaveParam(request);

		return attAnnualLeaveDao.getAttAnnualLeaveInfoCnt(paramMap);
	}
	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see
	 * com.siping.att.service.AttAnnualLeaveSer#getEsslLeaveInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getEsslLeaveInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request)); 

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = attAnnualLeaveDao.getEsslLeaveInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = attAnnualLeaveDao.getEsslLeaveInfo(paramMap);
		}

		return retrunList;
	}

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see
	 * com.siping.att.service.AttAnnualLeaveSer#getEsslLeaveInfoCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getEsslLeaveInfoCnt(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request)); 

		return attAnnualLeaveDao.getEsslLeaveInfoCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private LinkedHashMap setGetAttAnnualLeaveParam(HttpServletRequest request) {
		// 从session中取得登陆用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request)); 

		return paramMap;
	}

	@SuppressWarnings("rawtypes")
	public int deleteAttAnnualLeaveInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return attAnnualLeaveDao.deleteAttAnnualLeaveInfo(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int updateAttAnnualLeaveInfo(HttpServletRequest request) {
		// 从session中取得登陆用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		
		String jsonString = request.getParameter("jsonData") ;
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", paramMap) ;
		
		this.attAnnualLeaveDao.updateAttAnnualLeaveInfo(updateList);

		return 0;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int addAttAnnualLeaveInfo(HttpServletRequest request) {
		// 从session中取得登陆用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());

		this.attAnnualLeaveDao.addAttAnnualLeaveInfo(paramMap);

		return 0;
	}

	@SuppressWarnings("rawtypes")
	public int checkAddAttAnnualLeaveInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.attAnnualLeaveDao.checkAddAttAnnualLeaveInfo(paramMap);
	}

	@SuppressWarnings("rawtypes")
	public int createAttAnnualLeaveInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		this.attAnnualLeaveDao.createAttAnnualLeaveInfo(paramMap);

		return 0;
	}

	@SuppressWarnings("rawtypes")
	public int createAttAnnualLeaveInfo() {
 
		// 页面提交数据
		LinkedHashMap paramMap = new LinkedHashMap();
		this.attAnnualLeaveDao.createAttAnnualLeaveInfo(paramMap);

		return 0;
	}
}
