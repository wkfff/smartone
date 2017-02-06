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
import com.siping.system.dao.SystemPageStructureDao;
import com.siping.system.service.SystemPageStructureSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class SystemPageStructureSerImpl implements SystemPageStructureSer {
	Logger logger = Logger.getLogger(SystemPageStructureSerImpl.class);

	@Autowired
	private SystemPageStructureDao systemPageStructureDao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#getPageStructure(javax
	 * .servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPageStructure(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunList = systemPageStructureDao.getPageStructure(paramMap);

		return retrunList;
	}
 

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#getPageStructureDetailItemInfo
	 * (javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailItemInfo(HttpServletRequest request) {

		List retrunList = new ArrayList();
		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = systemPageStructureDao.getPageStructureDetailItemInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = systemPageStructureDao.getPageStructureDetailItemInfo(paramMap);
		}

		return retrunList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#getPageStructureDetailItemInfoCnt
	 * (javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes" })
	public int getPageStructureDetailItemInfoCnt(HttpServletRequest request) {
		int i = 0;
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		i = systemPageStructureDao.getPageStructureDetailItemInfoCnt(paramMap);
		return i;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#AddPageStructureDetailInfo
	 * (javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addPageStructureDetailInfo(HttpServletRequest request) {

		try {
			// session用户信息
			AdminBean admin = SessionUtil.getLoginUserFromSession(request);

			// 附加信息
			LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
			appendMap.put("CREATE_BY", admin.getAdminID());
			appendMap.put("CPNY_ID", admin.getCpnyId());

			// 页面提交数据
			LinkedHashMap paramMap = ObjectBindUtil
					.getRequestParamData(request);
			paramMap.remove("jsonData");
			paramMap.putAll(appendMap);
			
			int returnInt = this.systemPageStructureDao.addPageStructureInfo(paramMap);
			paramMap.put("RT_NO", returnInt);
			// 页面提交的JSON信息
			String jsonString = request.getParameter("jsonData");

			List<LinkedHashMap<String, Object>> detailList = ObjectBindUtil
					.getRequestJsonData(jsonString, paramMap);
			if(returnInt == 0){
				return 1;
			}else{
				this.systemPageStructureDao.addPageStructureDetailInfo(detailList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#getPageStructureDetailInfo
	 * (javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPageStructureDetailInfo(HttpServletRequest request) {

		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = systemPageStructureDao.getPageStructureDetailInfo(
					paramMap, NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = systemPageStructureDao
					.getPageStructureDetailInfo(paramMap);
		}

		return retrunList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.siping.system.service.SystemPageStructureSer#
	 * getPageStructureDetailInfoCnt(javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getPageStructureDetailInfoCnt(HttpServletRequest request) {

		int returnInt = 0;

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());

		returnInt = systemPageStructureDao.getPageStructureDetailInfoCnt(paramMap);

		return returnInt;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#deletePageStructureDetail
	 * (javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deletePageStructureDetailInfo(HttpServletRequest request) {

		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		this.systemPageStructureDao.deletePageStructureDetailInfo(paramMap);

		return 0;
	}


	@Override
	public int updatePageStructureDetailInfoOrder(HttpServletRequest request) {
		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		
		List<LinkedHashMap<String, Object>> itemList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);

		return this.systemPageStructureDao
				.updatePageStructureDetailInfoOrder(itemList);
	}  

	/**
	 * 获取信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		return paramMap;
	} 
}
