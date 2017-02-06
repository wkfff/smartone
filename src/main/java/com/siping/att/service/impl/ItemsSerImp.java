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

import com.siping.att.dao.ItemsDao;
import com.siping.att.service.ItemsSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class ItemsSerImp implements ItemsSer {

	Logger logger = Logger.getLogger(ItemsSerImp.class);

	@Autowired
	private ItemsDao itemsDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Object getItemObjectInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.itemsDao.getItemObjectInfo(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getItemInfoSelection(HttpServletRequest request) {
		List retrunList = new ArrayList();

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunList = this.itemsDao.getItemInfoSelection(paramMap);

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAppTypeSelectionList(HttpServletRequest request) {
		List retrunList = new ArrayList();

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunList = this.itemsDao.getAppTypeSelectionList(paramMap);

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getItemInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());


		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.itemsDao.getItemInfo(paramMap, NumberUtils
					.parseNumber(ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.itemsDao.getItemInfo(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getItemInfoTree(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunList = this.itemsDao.getItemInfoTree(paramMap);

		return retrunList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int addItemInfo(HttpServletRequest request) {
		int returnInt = 1;
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());


		returnInt = this.itemsDao.addItemInfo(paramMap);

		return returnInt;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public int checkItemInfo(HttpServletRequest request) {
		int returnInt = 1;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		returnInt = this.itemsDao.checkItemInfo(paramMap);

		return returnInt;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int updateItemInfo(HttpServletRequest request) {

		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATE_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		this.itemsDao.updateItemInfo(paramMap);

		return 0;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public int deleteItemInfo(HttpServletRequest request) {

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		this.itemsDao.deleteItemInfo(paramMap);

		return 0;
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getItemInfoCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
 
		return this.itemsDao.getItemInfoCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getItemParameterInfoList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		return this.itemsDao.getItemParameterInfoList(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Object getItemParameterInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));

		return this.itemsDao.getItemParameterInfo(paramMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int addItemParameterInfo(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		String[] dataTypes = request.getParameterValues("DATE_TYPE");
		String dataType = "";
		for (int i = 0; i < dataTypes.length; ++i) {
			dataType += dataTypes[i];
			if (i < dataTypes.length - 1) {
				dataType += ",";
			}
		}
		paramMap.put("DATE_TYPE", dataType);

		return this.itemsDao.addItemParameterInfo(paramMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int updateItemParameterInfo(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		String[] dataTypes = request.getParameterValues("DATE_TYPE");
		String dataType = "";
		for (int i = 0; i < dataTypes.length; ++i) {
			dataType += dataTypes[i];
			if (i < dataTypes.length - 1) {
				dataType += ",";
			}
		}
		paramMap.put("DATE_TYPE", dataType);

		return this.itemsDao.updateItemParameterInfo(paramMap);
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public int deleteItemParameterInfo(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.itemsDao.deleteItemParameterInfo(paramMap);
	}
}
