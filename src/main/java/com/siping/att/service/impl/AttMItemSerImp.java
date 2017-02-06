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

import com.siping.att.dao.AttMItemDao;
import com.siping.att.service.AttMItemSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttMItemSerImp implements AttMItemSer {

	Logger logger = Logger.getLogger(AttMItemSerImp.class);

	@Autowired
	private AttMItemDao attMItemDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getAttMItemObjectInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.attMItemDao.getAttMItemObjectInfo(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getAttMItemInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.attMItemDao.getAttMItemInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.attMItemDao.getAttMItemInfo(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getAttMItemInfoCnt(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request); 
		paramMap.put("CPNY_ID", admin.getCpnyId()); 
		// 页面提交数据   
		return this.attMItemDao.getAttMItemInfoCnt(paramMap);

	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addAttMItemInfo(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getActivity());
		paramMap.put("CPNY_ID", admin.getCpnyId()); 

		this.attMItemDao.addAttMItemInfo(paramMap);

		return 0;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int updateAttMItemInfo(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATE_BY", admin.getAdminID());

		this.attMItemDao.updateAttMItemInfo(paramMap);

		return 0;
	}

	@SuppressWarnings({ "rawtypes" })
	public int deleteAttMItemInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		this.attMItemDao.deleteAttMItemInfo(paramMap);

		return 0;
	}

	// @Override
	@SuppressWarnings({ "rawtypes" })
	public int checkDeleteAttMItemInfo(HttpServletRequest request) {
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.attMItemDao.checkDeleteAttMItemInfo(paramMap);
	}

	@Override
	public int updateAttMItemInfoCalOrder(HttpServletRequest request) {
		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());

		List<LinkedHashMap<String, Object>> itemList = ObjectBindUtil
				.getRequestJsonData(jsonString, appendMap);

		return this.attMItemDao.updateAttMItemInfoCalOrder(itemList);
	}

}
