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

import com.siping.att.dao.AttendanceKeeperDao;
import com.siping.att.service.AttendanceKeeperSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttendanceKeeperSerImp implements AttendanceKeeperSer {

	Logger logger = Logger.getLogger(AttendanceKeeperSerImp.class);

	@Autowired
	private AttendanceKeeperDao attendanceKeeperDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getAttendanceKeeper(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		return this.attendanceKeeperDao.getAttendanceKeeper(paramMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getAttendanceKeeperInfo(HttpServletRequest request) {

		List retrunList = new ArrayList();

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = attendanceKeeperDao.getAttendanceKeeperInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = attendanceKeeperDao.getAttendanceKeeperInfo(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addAttendanceKeeperInfo(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.remove("jsonData");

		this.attendanceKeeperDao.addAttendanceKeeperInfo(paramMap);

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertAttendanceKeeperList = ObjectBindUtil
				.getRequestJsonData(jsonString);

		this.attendanceKeeperDao
				.addAttendanceKeeperDeptInfo(insertAttendanceKeeperList);

		return 0;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int updateAttendanceKeeperInfo(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.remove("jsonData");

		this.attendanceKeeperDao.updateAttendanceKeeperInfo(paramMap);

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertAttendanceKeeperList = ObjectBindUtil
				.getRequestJsonData(jsonString, paramMap);

		this.attendanceKeeperDao
				.addAttendanceKeeperDeptInfo(insertAttendanceKeeperList);

		return 0;
	}

	@SuppressWarnings({ "rawtypes" })
	public int deleteAttendanceKeeperInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		this.attendanceKeeperDao.deleteAttendanceKeeperInfo(paramMap);

		return 0;
	}

	// @Override
	@SuppressWarnings({ "rawtypes" })
	public int getAttendanceKeeperInfoCnt(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return attendanceKeeperDao.getAttendanceKeeperInfoCnt(paramMap);
	}

	// @Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getAttendanceKeeperDeptInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		retrunList = attendanceKeeperDao.getAttendanceKeeperDeptInfo(paramMap);

		return retrunList;
	}

}
