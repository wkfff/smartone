package com.siping.web.utility.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.cust.service.SalesSettingSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.dao.UtilityCustInfoDao;
import com.siping.web.utility.dao.UtilityDocInfoDao;
import com.siping.web.utility.service.UtilityCustInfoSer;
import com.siping.web.utility.service.UtilityDocInfoSer;
import com.siping.web.utility.service.UtilityProdInfoSer;

@Service
public class UtilityDocInfoSerImpl implements UtilityDocInfoSer{
	
	Logger logger = Logger.getLogger(UtilityProdInfoSer.class);
	@Autowired
	private UtilityDocInfoDao utilityDocInfoDao;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getDocList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("EMP_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		return this.utilityDocInfoDao.getDocList(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getDocListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);	
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("EMP_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		return this.utilityDocInfoDao.getDocListCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getDocTypeList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		return this.utilityDocInfoDao.getDocTypeList(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getDocTypeListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);	
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		return this.utilityDocInfoDao.getDocTypeListCnt(paramMap);
	}

	
}
