package com.siping.ess.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.ess.dao.AffirmAppDao;
import com.siping.ess.service.AffirmAppSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AffirmAppSerImpl implements AffirmAppSer {


	Logger logger = Logger.getLogger(AffirmAppSerImpl.class);

	@Autowired
	private AffirmAppDao affirmAppDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmOtInfo(HttpServletRequest request)
			{
		Map returnMap = new LinkedHashMap<Object, Object>();
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		paramMap.put("adminID", admin.getAdminID());
		paramMap.put("affirmID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request)); 
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			returnMap = this.affirmAppDao.getAffirmOtInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else { 
			returnMap = this.affirmAppDao.getAffirmOtInfo(paramMap);
		}
		return returnMap;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmBTInfo(HttpServletRequest request)
			{
		Map returnMap = new LinkedHashMap<Object, Object>();
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		paramMap.put("adminID", admin.getAdminID());
		paramMap.put("affirmID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			returnMap = this.affirmAppDao.getAffirmBTInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else { 
			returnMap = this.affirmAppDao.getAffirmBTInfo(paramMap);
		}
		return returnMap;
	} 
 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmLeaveInfo(HttpServletRequest request)
			{
		Map returnMap = new LinkedHashMap<Object, Object>();
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		paramMap.put("adminID", admin.getAdminID());
		paramMap.put("affirmID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request)); 
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			returnMap = this.affirmAppDao.getAffirmLeaveInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else { 
			returnMap = this.affirmAppDao.getAffirmLeaveInfo(paramMap);
		}  
		return returnMap;
	}
	 
		@SuppressWarnings({ "rawtypes", "unchecked" })
		@Override
		public Map getAffirmCardtimeInfo(HttpServletRequest request)
				{
			Map returnMap = new LinkedHashMap<Object, Object>();
			Map paramMap = ObjectBindUtil.getRequestParamData(request);
			AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
			
			paramMap.put("adminID", admin.getAdminID());
			paramMap.put("affirmID", admin.getAdminID());
			paramMap.put("language", Messages.getLanguage(request)); 
			
			if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
				returnMap = this.affirmAppDao.getAffirmCardtimeInfo(paramMap,
						NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("pagesize")),
								Integer.class));
			} else { 
				returnMap = this.affirmAppDao.getAffirmCardtimeInfo(paramMap);
			}  
			return returnMap;
		}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmExpInfo(HttpServletRequest request)
			{
		Map returnMap = new LinkedHashMap<Object, Object>();
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		paramMap.put("adminID", admin.getAdminID());
		paramMap.put("affirmID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request)); 
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			returnMap = this.affirmAppDao.getAffirmExpInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else { 
			returnMap = this.affirmAppDao.getAffirmExpInfo(paramMap);
		}  
		return returnMap;
	}
	
	@Override
	public String affirmApp(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request); 
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		
		String jsonString = request.getParameter("jsonData");
		String appType = request.getParameter("appType");
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, appendMap);
		
		if (appType.equals("OtInfo")) {
			this.affirmAppDao.affirmOtApp(updateList);
		} else if (appType.equals("LeaveInfo")) {
			this.affirmAppDao.affirmLeaveApp(updateList);
		} else if (appType.equals("BTInfo")) {
			this.affirmAppDao.affirmBTApp(updateList);
		} else if (appType.equals("ExpInfo")) {
			this.affirmAppDao.affirmExpApp(updateList);
		} else if (appType.equals("CardtimeInfo")) {
			this.affirmAppDao.affirmCardtimeApp(updateList);
		} 
		
		return "";
	}

}
