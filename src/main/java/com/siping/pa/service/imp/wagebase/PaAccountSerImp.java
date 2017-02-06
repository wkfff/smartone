package com.siping.pa.service.imp.wagebase;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List; 

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.wagebase.PaAccountDao;
import com.siping.pa.service.wagebase.PaAccountSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PaAccountSerImp implements PaAccountSer {

	Logger logger = Logger.getLogger(PaAccountSerImp.class);

	@Autowired
	private PaAccountDao paAccountDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaAccountInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = this.setGetPaAccountParam(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = paAccountDao.getPaAccountInfo(paramMap, NumberUtils
				.parseNumber(ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
						ObjectUtils.toString(paramMap.get("pagesize")),
						Integer.class));
		} else {
			retrunList = paAccountDao.getPaAccountInfo(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getPaAccountInfoCnt(HttpServletRequest request) {
		LinkedHashMap paramMap = this.setGetPaAccountParam(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return paAccountDao.getPaAccountInfoCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private LinkedHashMap setGetPaAccountParam(HttpServletRequest request) {
		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));

		return paramMap;
	}

	public String updatePaAccountInfo(HttpServletRequest request) {
		// 页面参数
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);

		return this.paAccountDao.updatePaAccountInfo(updateList);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List getPaWhInfoList(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		
		return paAccountDao.getPaWhInfoList(paramMap);
	}

	@SuppressWarnings({ "unused", "rawtypes", "unchecked" })
	@Override
	public int getPaWhInfoListCnt(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		
		return paAccountDao.getPaWhInfoListCnt(paramMap);
	}

}
