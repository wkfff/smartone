package com.siping.web.utility.bean;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

public class ParamTransferObjectBean {
	
	public static final int ACTION_ADD = 1;
	public static final int ACTION_UPDATE = 2;
	
	private AdminBean admin;
	
	@SuppressWarnings("rawtypes")
	private Map paramMap;
	
	private int action;
	
    @SuppressWarnings("unchecked")
	public ParamTransferObjectBean(HttpServletRequest request) {
    	paramMap = ObjectBindUtil.getRequestParamData(request);
		admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		if(paramMap.get("type").equals("add")){
			action = ParamTransferObjectBean.ACTION_ADD;
		}
		if(paramMap.get("type").equals("update")){
			action = ParamTransferObjectBean.ACTION_UPDATE;
		}
	}

	public AdminBean getAdmin() {
		return admin;
	}

	@SuppressWarnings("rawtypes")
	public Map getParamMap() {
		return paramMap;
	}

	public int getAction() {
		return action;
	}

	
    
}
