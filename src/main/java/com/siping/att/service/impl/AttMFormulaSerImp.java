package com.siping.att.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttMFormulaDao;
import com.siping.att.service.AttMFormulaSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.GetMapByPaAttUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttMFormulaSerImp implements AttMFormulaSer {
	Logger logger = Logger.getLogger(AttMFormulaSerImp.class);

	@Autowired
	private AttMFormulaDao attMFormulaDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getAttMFormulaObjectInfo(HttpServletRequest request) {
		Object returnObj = new Object();
		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		returnObj = this.attMFormulaDao.getAttMFormulaObjectInfo(paramMap);
		return returnObj;
	}
 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getAttMFormulaInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.attMFormulaDao.getAttMFormulaInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.attMFormulaDao.getAttMFormulaInfo(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getAttMFormulaInfoCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		 
		return this.attMFormulaDao.getAttMFormulaInfoCnt(paramMap);
	}  
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int addAttMFormulaInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		this.attMFormulaDao.addAttMFormulaInfo(paramMap);

		return 0;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int updateAttMFormulaInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		this.attMFormulaDao.updateAttMFormulaInfo(paramMap);

		return 0;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getAttMFormulaCnInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		
		List formulaList = this.attMFormulaDao.getAttMFormulaInfo(paramMap);
		 
		Map<String, String> returnValue = new HashMap<String, String>();
		List itemList = this.attMFormulaDao.getAttMFormulaItemInfo(paramMap);
		for (int i = 0; i < itemList.size(); i++) {
			LinkedHashMap map = (LinkedHashMap) itemList.get(i);
			if (map.get("ID") != null && map.get("NAME") != null) {
				returnValue.put(map.get("ID").toString(), map.get("NAME")
						.toString());
			}
		}

		returnValue.put("ATT_ITEM.SHIFT_NO", "班次");
		returnValue.put("STA_ITEM.AR_MONTH", "考勤月");
		returnValue.put("ATT_ITEM.AR_DATE_STR", "考勤日期");

		GetMapByPaAttUtil.formularToCN(formulaList, returnValue, "AR");
		return formulaList;
	}

	@SuppressWarnings("rawtypes")
	public int deleteAttMFormulaInfo(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		this.attMFormulaDao.deleteAttMFormulaInfo(paramMap);
		return 0;
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
