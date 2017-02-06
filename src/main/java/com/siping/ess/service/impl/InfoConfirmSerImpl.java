package com.siping.ess.service.impl;

import java.util.LinkedHashMap;
import java.util.List; 

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.ess.dao.InfoConfirmDao;
import com.siping.ess.service.InfoConfirmSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
@Service
public class InfoConfirmSerImpl implements InfoConfirmSer {

	Logger logger = Logger.getLogger(InfoConfirmSerImpl.class);
	
	@Autowired
	private InfoConfirmDao infoConfirmDao;
 
	@Override
	public String confirmApp(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request); 
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		appendMap.put("CREATED_BY", admin.getAdminID()); 
		
		String jsonString = request.getParameter("jsonData");
		String appType = request.getParameter("appType");
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, appendMap);
		
		if (appType.equals("perInfo")) {
			this.infoConfirmDao.confirmPerInfo(updateList);
		} else if (appType.equals("whInfo")) {
			this.infoConfirmDao.confirmWhInfo(updateList);
		} else if (appType.equals("OtInfo")) {
			this.infoConfirmDao.confirmOtInfo(updateList);
		} else if (appType.equals("LeaveInfo")) {
			this.infoConfirmDao.confirmLeaveInfo(updateList);
		} else if (appType.equals("BTInfo")) {
			this.infoConfirmDao.confirmBizInfo(updateList);
		} else if (appType.equals("ExpInfo")) {
			this.infoConfirmDao.confirmExpInfo(updateList);
		} else if (appType.equals("CardtimeInfo")) {
			this.infoConfirmDao.confirmCardtimeInfo(updateList);
		} else if (appType.equals("ToolInfo")){
			this.infoConfirmDao.confirmToolInfo(updateList);
		}
		
		return "Y";
	}
	@Override
	public String delApp(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request); 
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		
		String jsonString = request.getParameter("jsonData");
		String appType = request.getParameter("appType");
		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, appendMap);
		
		if (appType.equals("perInfo")) {
			this.infoConfirmDao.delPersonInfo(updateList);
		} else if (appType.equals("whInfo")) {
			this.infoConfirmDao.delWhInfo(updateList);
		} else if (appType.equals("OtInfo")) {
			this.infoConfirmDao.delOtInfo(updateList);
		} else if (appType.equals("LeaveInfo")) {
			this.infoConfirmDao.delLeaveInfo(updateList);
		} else if (appType.equals("BTInfo")) {
			this.infoConfirmDao.delBTInfo(updateList);
		} else if (appType.equals("trainingInfo")) {
			this.infoConfirmDao.delTrainingInfo(updateList);
		} else if (appType.equals("ExpInfo")) {
			this.infoConfirmDao.delExpInfo(updateList);
		} else if (appType.equals("CardtimeInfo")) {
			this.infoConfirmDao.delCardtimeInfo(updateList);
		} else if (appType.equals("ToolInfo")) {
			this.infoConfirmDao.delToolInfo(updateList);
		}
		
		return "";
	}
}
