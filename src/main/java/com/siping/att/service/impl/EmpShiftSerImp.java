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

import com.siping.att.dao.EmpShiftDao;
import com.siping.att.service.EmpShiftSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class EmpShiftSerImp implements EmpShiftSer {

	Logger logger = Logger.getLogger(EmpShiftSerImp.class);

	@Autowired
	private EmpShiftDao empShiftDao;

	@SuppressWarnings({ "rawtypes" })
	public List getShift010() {
		return this.empShiftDao.getShift010();
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addEmpShift(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());

		if (paramMap != null && !paramMap.get("TYPE").equals("")) {
			String shiftNo = "";
			String[] shiftNos = request.getParameter("SHIFT_NO").toString()
					.split(",");
			for(int i=0;i<shiftNos.length-1;i++){
				shiftNo += shiftNos[i] + ",";
			}
			shiftNo += shiftNos[shiftNos.length-1];
			paramMap.put("SHIFT_NO", shiftNo);
			this.empShiftDao.addEmpShift(paramMap);
		}

		return 0;
	}

	/*
	 * 已经排班人员信息 (non-Javadoc)
	 * 
	 * @see com.siping.att.service.EmpShiftSer#getSchedulingEmpInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getShiftSelectedInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CREATED_BY", admin.getAdminID());

		retrunList = this.empShiftDao.getShiftSelectedInfo(paramMap);

		return retrunList;
	}

	/*
	 * 已经排班人员信息 (non-Javadoc)
	 * 
	 * @see com.siping.att.service.EmpShiftSer#getSchedulingEmpInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getSchedulingEmpInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.empShiftDao.getSchedulingEmpInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.empShiftDao.getSchedulingEmpInfo(paramMap);
		}

		return retrunList;
	}

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see com.siping.att.service.EmpShiftSer#addShiftedInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int addShiftedInfo(HttpServletRequest request) {

		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());

		return this.empShiftDao.addShiftedInfo(paramMap);
	}

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see com.siping.att.service.EmpShiftSer#deleteShiftedInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int deleteShiftedInfo(HttpServletRequest request) {

		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());

		return this.empShiftDao.deleteShiftedInfo(paramMap);
	}

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see com.siping.att.service.EmpShiftSer#upShiftedInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes" })
	public int upShiftedInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.empShiftDao.upShiftedInfo(paramMap);
	}

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see com.siping.att.service.EmpShiftSer#upShiftedInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes" })
	public int downShiftedInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.empShiftDao.downShiftedInfo(paramMap);
	}

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see
	 * com.siping.att.service.EmpShiftSer#getSchedulingEmpInfoCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getSchedulingEmpInfoCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());

		return this.empShiftDao.getSchedulingEmpInfoCnt(paramMap);
	}

	/*
	 * 已经排班人员信息 (non-Javadoc)
	 * 
	 * @see com.siping.att.service.EmpShiftSer#getSchedulingEmpInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getEmpShiftDetailInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.empShiftDao.getEmpShiftDetailInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.empShiftDao.getEmpShiftDetailInfo(paramMap);
		}

		return retrunList;
	}

	/*
	 * 年休假信息 (non-Javadoc)
	 * 
	 * @see
	 * com.siping.att.service.EmpShiftSer#getSchedulingEmpInfoCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getEmpShiftDetailInfoCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());

		return this.empShiftDao.getEmpShiftDetailInfoCnt(paramMap);
	}

	/**
	 * 获取信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public Map getRequestParamData(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return paramMap;
	}
}
