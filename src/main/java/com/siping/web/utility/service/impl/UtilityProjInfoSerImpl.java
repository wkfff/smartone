package com.siping.web.utility.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.dao.UtilityDocInfoDao;
import com.siping.web.utility.dao.UtilityProjInfoDao;
import com.siping.web.utility.service.UtilityProjInfoSer;

@Service
public class UtilityProjInfoSerImpl implements UtilityProjInfoSer {

	@Autowired
	private UtilityProjInfoDao utilityProjInfoDao;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List getProjectProcessList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("EMP_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.utilityProjInfoDao.getProjectProcessList(paramMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int getProjectProcessListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);	
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("EMP_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.utilityProjInfoDao.getProjectProcessListCnt(paramMap);
	}

}
