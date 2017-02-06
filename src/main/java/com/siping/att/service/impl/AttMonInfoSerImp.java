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

import com.siping.att.dao.AttMonInfoDao; 
import com.siping.att.service.AttMonInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttMonInfoSerImp implements AttMonInfoSer {
	Logger logger = Logger.getLogger(AttMonInfoSerImp.class);

	@Autowired
	private AttMonInfoDao attMonInfoDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getAttColumns(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		List retrunList = this.attMonInfoDao.getAttColumns(paramMap);

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getAttColumnsParam(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		List paramList = this.attMonInfoDao.getAttSqlColumns(paramMap);
		String paramString = "";
		for (int i = 0; i < paramList.size(); i++) {
			LinkedHashMap map = (LinkedHashMap) paramList.get(i);
			paramString += "AR_HISTORY."+map.get("ITEM_ID");
			if (i == paramList.size() - 1) {
				paramString += " ";
			} else {
				paramString += ", ";
			}
		}
		return paramString;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getAttMonInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		//paramMap.put("isSupervisor",this.utilityEmpInfoSer.isSupervisor(request));
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("sqlStatement", this.getAttColumnsParam(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.attMonInfoDao.getAttMonInfo(paramMap, NumberUtils
					.parseNumber(ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.attMonInfoDao.getAttMonInfo(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getAttMonInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		//paramMap.put("isSupervisor",this.utilityEmpInfoSer.isSupervisor(request));
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));

		return this.attMonInfoDao.getAttMonInfoCnt(paramMap);
	}
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		return paramMap;
	}
}
