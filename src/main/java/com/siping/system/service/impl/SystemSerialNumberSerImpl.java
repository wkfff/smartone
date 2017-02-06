package com.siping.system.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.system.bean.AdminBean;
import com.siping.system.dao.SystemSerialNumberDao;
import com.siping.system.service.SystemSerialNumberSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class SystemSerialNumberSerImpl implements SystemSerialNumberSer {
	Logger logger = Logger.getLogger(SystemSerialNumberSerImpl.class);

	@Autowired
	private SystemSerialNumberDao systemSerialNumberDao;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAllSerialNum(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		List retrunList = new ArrayList(); 
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		if(paramMap.get("CPNY_ID")==null||paramMap.get("CPNY_ID").equals("")){
			paramMap.put("CPNY_ID", admin.getCpnyId()); 
		}
		paramMap.put("language", Messages.getLanguage(request));
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.systemSerialNumberDao.getAllSerialNum(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.systemSerialNumberDao.getAllSerialNum(paramMap);
		}
		
		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getAllSerialNumCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		
		paramMap.put("language", Messages.getLanguage(request)); 
		if(paramMap.get("CPNY_ID")==null||paramMap.get("CPNY_ID").equals("")){
			paramMap.put("CPNY_ID", admin.getCpnyId()); 
		} 
		
		return this.systemSerialNumberDao.getAllSerialNumCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String addSerialNum(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CREATED_BY", admin.getAdminID()) ;
		paramMap.put("UPDATED_BY", admin.getAdminID()) ;
		paramMap.put("CPNY_ID", admin.getCpnyId()) ;

		return this.systemSerialNumberDao.addSerialNum(paramMap);	
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String deleteSerialNum(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("UPDATED_BY", admin.getAdminID()) ;
		paramMap.put("CPNY_ID", admin.getCpnyId()) ;
		
		return this.systemSerialNumberDao.deleteSerialNum(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String updateSerialNum(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		// 页面提交数据
		paramMap.put("UPDATED_BY", admin.getAdminID()) ;
		
		return this.systemSerialNumberDao.updateSerialNum(paramMap);
	}

}
