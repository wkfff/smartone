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

import com.siping.att.dao.ShiftDao;
import com.siping.att.service.ShiftSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class ShiftSerImp implements ShiftSer {

	Logger logger = Logger.getLogger(ShiftSerImp.class);

	@Autowired
	private ShiftDao shiftDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getShiftInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.shiftDao.getShiftInfo(paramMap);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getShiftInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = shiftDao.getShiftInfoList(paramMap, NumberUtils
					.parseNumber(ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = shiftDao.getShiftInfoList(paramMap);
		}

		return retrunList;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getShiftSelectionList(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
 
		retrunList = shiftDao.getShiftSelectionList(paramMap);
		 
		return retrunList;
	} 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addShiftInfo(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", paramMap);

		this.shiftDao.addShiftInfo(insertList);

		return 0;
	}

	@SuppressWarnings({ "rawtypes" })
	public int checkShiftInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
	
		return this.shiftDao.checkShiftInfo(paramMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int updateShiftInfo(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", paramMap);
  
		this.shiftDao.updateShiftInfo(updateList);

		return 0;
	}
	// @Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getShiftInfoCnt(HttpServletRequest request) {
	
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
	
		return shiftDao.getShiftInfoCnt(paramMap);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getShiftParameterInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
	
		return shiftDao.getShiftParameterInfo(paramMap);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getShiftParameterInfoObj(HttpServletRequest request) {
	
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
	
		return this.shiftDao.getShiftParameterInfoObj(paramMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int updateShiftParameterInfo(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request); 
		paramMap.put("UPDATED_BY", admin.getAdminID()); 

		this.shiftDao.updateShiftParameterInfo(paramMap);

		return 0;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addShiftParameterInfo(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request); 
		paramMap.put("CREATED_BY", admin.getAdminID()); 

		this.shiftDao.addShiftParameterInfo(paramMap);

		return 0;
	}

	@SuppressWarnings({ "rawtypes" })
	public int deleteShiftInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		this.shiftDao.deleteShiftInfo(paramMap);

		return 0;
	}

	@SuppressWarnings({ "rawtypes" })
	public int deleteShiftParameterInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		this.shiftDao.deleteShiftParameterInfo(paramMap);

		return 0;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getShiftGroupInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = shiftDao.getShiftGroupInfoList(paramMap, NumberUtils
					.parseNumber(ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = shiftDao.getShiftGroupInfoList(paramMap);
		}

		return retrunList;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int getShiftGroupInfoListCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
	
		return shiftDao.getShiftGroupInfoListCnt(paramMap);
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int checkShiftGroupInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		
		return this.shiftDao.checkShiftGroupInfo(paramMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int addShiftGroupInfo(HttpServletRequest request) {
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", paramMap);

		this.shiftDao.addShiftGroupInfo(insertList);
		return 0;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int updateShiftGroupInfo(HttpServletRequest request) {
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", paramMap);
		this.shiftDao.updateShiftGroupInfo(updateList);
		return 0;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int deleteShiftGroupInfo(HttpServletRequest request) {
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		this.shiftDao.deleteShiftGroupInfo(paramMap);
		return 0;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Object getShiftGroupInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.shiftDao.getShiftGroupInfo(paramMap);
	}

	@Override
	public int deleteShiftGroupEmpInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);

		return this.shiftDao.deleteShiftGroupEmpInfo(delList);
	}
	@Override
	public int addGroupEmpInfo(HttpServletRequest request) {
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		this.shiftDao.addGroupEmpInfo(insertList);
		return 0;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getShiftGroupEmpInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.shiftDao.getShiftGroupEmpInfoList(
					paramMap, NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));

		} else {
			retrunList = this.shiftDao
					.getShiftGroupEmpInfoList(paramMap);
		}
		return retrunList;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getShiftGroupEmpInfoListCnt(HttpServletRequest request) {
		int retrunInt = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunInt = this.shiftDao.getShiftGroupEmpInfoListCnt(paramMap);

		return retrunInt;
	}

	@Override
	public int checkShiftGroupEmpDate(HttpServletRequest request) {
		String jsonString = request.getParameter("jsonData");
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);
		int count = 0;
		for(Object o:delList){
			count += this.shiftDao.checkShiftGroupEmpDate(o);
		}
		return count;
	}

}
