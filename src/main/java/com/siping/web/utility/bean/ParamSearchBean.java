package com.siping.web.utility.bean;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

public class ParamSearchBean {

	private AdminBean admin;
	@SuppressWarnings("rawtypes")
	private Map paramMap;
	
	@SuppressWarnings("unchecked")
	public ParamSearchBean(HttpServletRequest request){
		paramMap = ObjectBindUtil.getRequestParamData(request);
		admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
	}

	public AdminBean getAdmin() {
		return admin;
	}

	public void setAdmin(AdminBean admin) {
		this.admin = admin;
	}

	@SuppressWarnings("rawtypes")
	public Map getParamMap() {
		return paramMap;
	}

	public void setParamMap(Map paramMap) {
		this.paramMap = paramMap;
	}
	
}
