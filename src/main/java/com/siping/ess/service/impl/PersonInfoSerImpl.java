package com.siping.ess.service.impl;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.ess.dao.PersonInfoDao;
import com.siping.ess.service.PersonInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PersonInfoSerImpl implements PersonInfoSer {

	Logger logger = Logger.getLogger(PersonInfoSerImpl.class);

	@Autowired
	private PersonInfoDao personInfoDao;
 
	/**
	 * 查询毕业学校
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getEducationInfoList(HttpServletRequest request)
			throws Exception {
		Map param = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		param.put("EMPID", admin.getAdminID());
		return personInfoDao.getEducationInfoList(param ,Integer.parseInt(request
				.getParameter("page").toString()), Integer.parseInt(request
						.getParameter("pagesize").toString()));
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getEvaluateforList(HttpServletRequest request) throws Exception {
		Map param = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		param.put("EMPID", admin.getAdminID());
		return personInfoDao.getEvaluateforList(param ,Integer.parseInt(request
				.getParameter("page").toString()), Integer.parseInt(request
						.getParameter("pagesize").toString()));
	}
	

	
	
}
