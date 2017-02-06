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

import com.siping.att.dao.AttMonthDao;
import com.siping.att.service.AttMonthSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttMonthSerImp implements AttMonthSer {
	Logger logger = Logger.getLogger(AttMonthSerImp.class);

	@Autowired
	private AttMonthDao attMonthDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getAttColumns(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		List retrunList = this.attMonthDao.getAttColumns(paramMap);

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getAttColumnsParam(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		List paramList = this.attMonthDao.getAttSqlColumns(paramMap);
		String paramString = "";
		for (int i = 0; i < paramList.size(); i++) {
			LinkedHashMap map = (LinkedHashMap) paramList.get(i);
			paramString += map.get("COLUMN_NAME");
			if (i == paramList.size() - 1) {
				paramString += "";
			} else {
				paramString += ",";
			}
		}
		return paramString;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getAttMonthInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("sqlStatement", this.getAttColumnsParam(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.attMonthDao.getAttMonthInfo(paramMap, NumberUtils
					.parseNumber(ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.attMonthDao.getAttMonthInfo(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getAttMonthInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));

		return this.attMonthDao.getAttMonthInfoCnt(paramMap);
	}
 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int updateAttMonthInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		// 页面参数
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> infoList = ObjectBindUtil
				.getRequestJsonData(jsonString);

		List paramList = this.attMonthDao.getAttSqlColumns(paramMap);
		for (int j = 0; j < infoList.size(); j++) {

			LinkedHashMap paraMap = (LinkedHashMap) infoList.get(j);
			String sqlparamString = "UPDATE AR_HISTORY SET ";
			for (int i = 0; i < paramList.size(); i++) {
				LinkedHashMap map = (LinkedHashMap) paramList.get(i);
				sqlparamString += map.get("COLUMN_NAME") + "="
						+ paraMap.get(map.get("COLUMN_NAME"));
				if (i != paramList.size() - 1) {
					sqlparamString += ",";
				}
			}
			sqlparamString += " WHERE AR_MONTH ='" + paramMap.get("ATT_MONTH").toString() + "' AND  EMPID= "
					+ "'" + paraMap.get("EMPID") + "'";
			System.out.println(sqlparamString);
			paraMap.put("sql", sqlparamString);
			this.attMonthDao.updateAttMonthInfo(paraMap);
		}

		return 0;
	}

}
