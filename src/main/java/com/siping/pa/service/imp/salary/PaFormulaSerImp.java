package com.siping.pa.service.imp.salary;

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

import com.siping.pa.dao.salary.PaFormulaDao;
import com.siping.pa.service.salary.PaFormulaSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.GetMapByPaAttUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PaFormulaSerImp implements PaFormulaSer {

	Logger logger = Logger.getLogger(PaFormulaSerImp.class);

	@Autowired
	private PaFormulaDao paFormulaDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getPaFormulaObjectInfo(HttpServletRequest request) {
		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return paFormulaDao.getPaFormulaObjectInfo(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaFormulaInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.paFormulaDao.getPaFormulaInfo(paramMap,
				NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.paFormulaDao.getPaFormulaInfo(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getPaFormulaInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.paFormulaDao.getPaFormulaInfoCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaFormulaCnInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		// 工资计算公式
		List paFormulaInfo = this.getPaFormulaInfo(request);
		// 计算公式项目列表
		List formulaItemList = this.paFormulaDao.getFormulaItemInfo(paramMap);
		Map<String, String> returnValue = new HashMap<String, String>();
		
		for (int i = 0; i < formulaItemList.size(); i++) {
			LinkedHashMap map = (LinkedHashMap) formulaItemList.get(i);
			if (map.get("ID") != null && map.get("NAME") != null) {
				returnValue.put(map.get("ID").toString(), map.get("NAME").toString());
			}
		}
		// 替换所有项目ID为中文
		GetMapByPaAttUtil.formularToCN(paFormulaInfo, returnValue, "PA");

		return paFormulaInfo;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String addPaFormulaInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return paFormulaDao.addPaFormulaInfo(paramMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked" })
	public String updatePaFormulaInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return paFormulaDao.updatePaFormulaInfo(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String deletePaFormulaInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return paFormulaDao.deletePaFormulaInfo(paramMap);
	}

	@SuppressWarnings("rawtypes")
	public String initPaFormulaInfo(HttpServletRequest request) {
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return paFormulaDao.initPaFormulaInfo(paramMap);
	}
}
