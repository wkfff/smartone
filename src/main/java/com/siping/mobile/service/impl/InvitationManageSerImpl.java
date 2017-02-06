package com.siping.mobile.service.impl;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.RuntimeService;
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.mobile.dao.InvitationManageDao;
import com.siping.mobile.service.InvitationManageSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.RandomInvationUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.SqlMapClientSupport;

@Service
public class InvitationManageSerImpl extends SqlMapClientSupport implements InvitationManageSer {

	Logger logger = Logger.getLogger(InvitationManageSerImpl.class);
	@Autowired
	private InvitationManageDao invitationManageDao;
	@Autowired
	private RuntimeService runtimeService;
	@Override
	public String generateInvitation() {
		RandomInvationUtil randomUtil = new RandomInvationUtil();
		SecureRandom random = new SecureRandom();
		int randomNum = random.nextInt(100000);
		return randomUtil.randomInvation(randomNum);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String addInvitation(HttpServletRequest request) throws Exception {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("CREATED_BY", admin.getAdminID());
		String custNo = request.getParameter("CUST_NO");
		//判断custNo是否为空，为空就不绑定客户；不为空就绑定客户
		if (custNo == null || custNo.equals("")) {
			this.invitationManageDao.addInvitationNotBind(paramMap);
		}else {
			this.invitationManageDao.addInvitationBind(paramMap);
		}
		return "Y";
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getCntByCondition(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.invitationManageDao.getCntByCondition(paramMap);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getInvitationList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.invitationManageDao.getInvitationList(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		}
		return retrunList;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getInvitationCnt(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.invitationManageDao.getInvitationCnt(paramMap);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String deleteInvitation(HttpServletRequest request) throws Exception {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.invitationManageDao.deleteInvitation(paramMap);
	}
	
}
