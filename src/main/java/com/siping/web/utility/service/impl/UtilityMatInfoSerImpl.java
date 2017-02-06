package com.siping.web.utility.service.impl;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.service.UtilityMatInfoSer;
import com.siping.web.utility.dao.*;

@Service
public class UtilityMatInfoSerImpl implements UtilityMatInfoSer {

	Logger logger = Logger.getLogger(UtilityMatInfoSer.class);
	@Autowired
	private UtilityMatInfoDao utilityMatInfoDao;
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getMaterialList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID",admin.getCpnyId());
		return this.utilityMatInfoDao.getMaterialList(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getMaterialListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID",admin.getCpnyId());
		return this.utilityMatInfoDao.getMaterialListCnt(paramMap);
	}
}
