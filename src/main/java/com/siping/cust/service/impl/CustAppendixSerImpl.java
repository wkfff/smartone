package com.siping.cust.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.cust.dao.CustAppendixDao;
import com.siping.cust.service.CustAppendixSer;
import com.siping.cust.service.SalesSettingSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
@Service
public class CustAppendixSerImpl implements CustAppendixSer {

	@Autowired
	private CustAppendixDao custAppendixDao;
	@Autowired
	private SalesSettingSer salesSettingSer;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAppendixList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("EMP_ID", admin.getAdminID());
		paramMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
		return this.custAppendixDao.getAppendixList(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getAppendixListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("EMP_ID", admin.getAdminID());
		paramMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
		return this.custAppendixDao.getAppendixListCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String removeAppendix(HttpServletRequest request) {
		String resultStr = "Y";
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		try{
			this.custAppendixDao.removeAppendix(paramMap);
		}catch (SQLException e){
			resultStr = e.getMessage();
		}
		return resultStr;
	}

}
