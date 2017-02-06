package com.siping.pa.service.imp.wagebase;

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

import com.siping.pa.dao.wagebase.PaBasicItemDao;
import com.siping.pa.service.wagebase.PaBasicItemSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PaBasicItemSerImp implements PaBasicItemSer {

	Logger logger = Logger.getLogger(PaBasicItemSerImp.class);

	@Autowired
	private PaBasicItemDao paBasicItemDao;
	@SuppressWarnings("rawtypes")
	public Object getPaBasicItemObjectInfo(HttpServletRequest request) {
		Object returnObj = new Object();
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		returnObj = paBasicItemDao.getPaBasicItemObjectInfo(paramMap);
		return returnObj;
	}

	@SuppressWarnings("rawtypes")
	public List getPaBasicItemInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = this.setGetPaBasicItemParam(request);
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = paBasicItemDao.getPaBasicItemInfo(paramMap,
				NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = paBasicItemDao.getPaBasicItemInfo(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings("rawtypes")
	public int getPaBasicItemInfoCnt(HttpServletRequest request) {
		// 页面提交数据
		LinkedHashMap paramMap = this.setGetPaBasicItemParam(request);
		return paBasicItemDao.getPaBasicItemInfoCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private LinkedHashMap setGetPaBasicItemParam(HttpServletRequest request) {
		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));

		return paramMap;
	}

	@Override
	public void addPaBasicItemInfo(HttpServletRequest request) throws SQLException{
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
			.getRequestJsonData(jsonString, "add", appendMap);
		
		this.paBasicItemDao.addPaBasicItemInfo(insertList);
	}

	@Override
	public void updatePaBasicItemInfo(HttpServletRequest request) throws SQLException{
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getAdminID());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
			.getRequestJsonData(jsonString, "update", appendMap);
		
		this.paBasicItemDao.updatePaBasicItemInfo(updateList);
	}

	// @Override
	@SuppressWarnings({ "unchecked" })
	public int checkDeletePaBasicItemInfo(HttpServletRequest request) {
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil
			.getRequestParamData(request);
		return this.paBasicItemDao.checkDeletePaBasicItemInfo(paramMap);
	}

	// @Override
	@SuppressWarnings({ "unchecked" })
	public String deletePaBasicItemInfo(HttpServletRequest request) {
		// 附加信息
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.paBasicItemDao.deletePaBasicItemInfo(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaBasicItemDataInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.paBasicItemDao.getPaBasicItemDataInfo(paramMap,
				NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.paBasicItemDao.getPaBasicItemDataInfo(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getPaBasicItemDataInfoCnt(HttpServletRequest request) {
		int retrunInt = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		
		retrunInt = paBasicItemDao.getPaBasicItemDataInfoCnt(paramMap);
		return retrunInt;
	}

	public String updatePaBasicItemDataInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		// 页面参数
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updatePaBasicItemDataList = ObjectBindUtil
			.getRequestJsonData(jsonString, appendMap);
		return this.paBasicItemDao.updatePaBasicItemDataInfo(updatePaBasicItemDataList);
	}

	@SuppressWarnings("unchecked")
	public String initializePaBasicItemDataInfo(HttpServletRequest request) {
		// 附加信息
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil
				.getRequestParamData(request);
		return this.paBasicItemDao.initializePaBasicItemDataInfo(paramMap);
	}

	public String addPaBasicItemDataInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		// 页面参数
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> addPaBasicItemDataList = ObjectBindUtil
			.getRequestJsonData(jsonString, appendMap);
		return this.paBasicItemDao.addPaBasicItemDataInfo(addPaBasicItemDataList);
	}

	public String deletePaBasicItemDataInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		// 页面参数
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> deleteList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);

		return this.paBasicItemDao.deletePaBasicItemDataInfo(deleteList);
	}
	 
	public int updatePaBasicItemDataActivityInfo() { 
		try {
			this.paBasicItemDao.updatePaBasicItemDataActivityInfo();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaBasicItemDataEmpInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.paBasicItemDao.getPaBasicItemDataEmpInfo(
				paramMap, NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.paBasicItemDao.getPaBasicItemDataEmpInfo(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getPaBasicItemDataEmpInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.paBasicItemDao.getPaBasicItemDataEmpInfoCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaBasicItemDataOtherInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.paBasicItemDao.getPaBasicItemDataOtherInfo(
				paramMap, NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.paBasicItemDao.getPaBasicItemDataOtherInfo(paramMap);
		}

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getPaBasicItemDataOtherInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.paBasicItemDao.getPaBasicItemDataOtherInfoCnt(paramMap);
	}

}
