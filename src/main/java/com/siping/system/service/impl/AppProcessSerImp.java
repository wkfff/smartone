package com.siping.system.service.impl;

import java.sql.SQLException;
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
import com.siping.system.dao.AppProcessDao;
import com.siping.system.dao.BasicMaintenanceDao;
import com.siping.system.service.AppProcessSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil; 

@Service
public class AppProcessSerImp implements AppProcessSer {

	Logger logger = Logger.getLogger(AppProcessSerImp.class);

	@Autowired
	private AppProcessDao appProcessDao;
	@Autowired
	private BasicMaintenanceDao basicMaintenanceDao;

	/**
	 * 获取个人流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAppProcessPInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		if (paramMap.get("DEPTID") == null) {
			paramMap.put("DEPTID", admin.getDeptID());
		}
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.appProcessDao.getAppProcessPInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.appProcessDao.getAppProcessPInfo(paramMap);
		}

		return retrunList;
	}

	/**
	 * 获取个人流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getAppProcessPInfoCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		if (paramMap.get("DEPTID") == null) {
			paramMap.put("DEPTID", admin.getDeptID());
		}

		return this.appProcessDao.getAppProcessPInfoCnt(paramMap);
	}

	/**
	 * 获取个人流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAppProcessPAInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("PARENTCODE", "ApplyTypeCode");
		List appTypeList = this.basicMaintenanceDao
				.getSysCodeSelectList(paramMap);
		paramMap.put("appTypeList", appTypeList);
		retrunList = this.appProcessDao.getAppProcessPAInfo(paramMap);

		return retrunList;
	}
	/**
	 * 获取部门流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAppProcessDAInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("PARENTCODE", "ApplyTypeCode");
		List appTypeList = this.basicMaintenanceDao
				.getSysCodeSelectList(paramMap);
		paramMap.put("appTypeList", appTypeList);
		retrunList = this.appProcessDao.getAppProcessDAInfo(paramMap);

		return retrunList;
	} 
	/**
	 * 获取流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAppProcessInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		retrunList = this.appProcessDao.getAppProcessInfo(paramMap);

		return retrunList;
	}

	/**
	 * 获取部门流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAppProcessDInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.appProcessDao.getAppProcessDInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.appProcessDao.getAppProcessDInfo(paramMap);
		}

		return retrunList;
	}

	/**
	 * 获取部门流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public int getAppProcessDInfoCnt(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.appProcessDao.getAppProcessDInfoCnt(paramMap);
	}

	/**
	 * 获取个人流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAppProcessPInfoObj(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		return this.appProcessDao.getAppProcessPInfoObj(paramMap);
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

	/**
	 * 获取部门流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAppProcessDInfoObj(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		return this.appProcessDao.getAppProcessDInfoObj(paramMap);
	}

	/**
	 * 添加跟人流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int addAppProcessPInfo(HttpServletRequest request) {
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 附加信息
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		;
		appendMap.put("CREATED_BY", admin.getAdminID());

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.remove("jsonData");
		paramMap.putAll(appendMap);

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertAppProcessPInfoList = ObjectBindUtil
				.getRequestJsonData(jsonString, paramMap);

		try {
			this.appProcessDao.addAppProcessPInfo(insertAppProcessPInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 添加部门流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int addAppProcessDInfo(HttpServletRequest request) {
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 附加信息
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		;
		appendMap.put("CREATED_BY", admin.getAdminID());

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.remove("jsonData");
		paramMap.putAll(appendMap);

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertAppProcessPInfoList = ObjectBindUtil
				.getRequestJsonData(jsonString, paramMap);
 
		try {
			this.appProcessDao.addAppProcessDInfo(insertAppProcessPInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 修改个人流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int updateAppProcessPInfo(HttpServletRequest request) {
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 附加信息
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		;
		appendMap.put("UPDATE_BY", admin.getAdminID());

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.remove("jsonData");
		paramMap.remove("jsonMenuCodeString");
		paramMap.putAll(appendMap);

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");
		String jsonMenuCodeString = request.getParameter("jsonDataMenuCode");

		List<LinkedHashMap<String, Object>> insertRolesGroupPageList = ObjectBindUtil
				.getRequestJsonData(jsonString, paramMap);

		List<LinkedHashMap<String, Object>> deleteRolesGroupPageList = ObjectBindUtil
				.getRequestJsonData(jsonMenuCodeString, paramMap);

		paramMap.put("insertRolesGroupPageList", insertRolesGroupPageList);
		paramMap.put("deleteRolesGroupPageList", deleteRolesGroupPageList);

		this.appProcessDao.updateAppProcessPInfo(paramMap);

		return 0;
	}

	/**
	 * 修改部门流程信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int updateAppProcessDInfo(HttpServletRequest request) {
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 附加信息
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		;
		appendMap.put("UPDATE_BY", admin.getAdminID());

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.remove("jsonData");
		paramMap.remove("jsonMenuCodeString");
		paramMap.putAll(appendMap);

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");
		String jsonMenuCodeString = request.getParameter("jsonDataMenuCode");

		List<LinkedHashMap<String, Object>> insertRolesGroupPageList = ObjectBindUtil
				.getRequestJsonData(jsonString, paramMap);

		List<LinkedHashMap<String, Object>> deleteRolesGroupPageList = ObjectBindUtil
				.getRequestJsonData(jsonMenuCodeString, paramMap);

		paramMap.put("insertRolesGroupPageList", insertRolesGroupPageList);
		paramMap.put("deleteRolesGroupPageList", deleteRolesGroupPageList);

		this.appProcessDao.updateAppProcessDInfo(paramMap);

		return 0;
	}

	/**
	 * 删除个人流程信息
	 * 
	 * @param request
	 * @return
	 */ 
	@Override
	public int deleteAppProcessPInfo(HttpServletRequest request) { 
		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> infoList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		return appProcessDao.deleteAppProcessPInfo(infoList);
	}

	/**
	 * 删除部门流程信息
	 * 
	 * @param request
	 * @return
	 */ 
	@Override
	public int deleteAppProcessDInfo(HttpServletRequest request) {
		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> infoList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		return appProcessDao.deleteAppProcessDInfo(infoList);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getSendEmailInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.appProcessDao.getSendEmailInfo(paramMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int getSendEmailInfoCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.appProcessDao.getSendEmailInfoCnt(paramMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String updateSendEmailInfo(HttpServletRequest request) throws SQLException {
		String resultString = "Y";
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		this.appProcessDao.updateSendEmailInfo(paramMap);
		return resultString;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String addSendEmailInfo(HttpServletRequest request) throws SQLException {
		String resultString = "Y";
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		this.appProcessDao.addSendEmailInfo(paramMap);
		return resultString;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String deleteSendEmailInfo(HttpServletRequest request) throws SQLException {
		String resultString = "Y";
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		this.appProcessDao.deleteSendEmailInfo(paramMap);
		return resultString;
	}
	

}
