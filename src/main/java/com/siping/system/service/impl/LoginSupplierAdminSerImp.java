package com.siping.system.service.impl;

import java.sql.SQLException;
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

import com.siping.hrm.dao.TransferOrderDao;
import com.siping.system.bean.AdminBean;
import com.siping.system.dao.LoginSupplierAdminDao;
import com.siping.system.service.LoginSupplierAdminSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class LoginSupplierAdminSerImp implements LoginSupplierAdminSer {

	Logger logger = Logger.getLogger(LoginSupplierAdminSerImp.class);
	
	@Autowired
	private LoginSupplierAdminDao loginSupplierAdminDao;
	
	@Autowired
	private TransferOrderDao transferOrderDao;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Object getLoginSupplierAdminInfoObj(HttpServletRequest request) {
		
		AdminBean admin=SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("ADMINID", admin.getAdminID());
		return this.loginSupplierAdminDao.getLoginSupplierAdminInfoObj(paramMap) ; 
	}

	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	@Override
	public List getLoginSupplierAdminRolesGroupList(HttpServletRequest request){

		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		
		return this.loginSupplierAdminDao.getLoginSupplierAdminRolesGroupList(paramMap) ; 
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getLoginSupplierAdminInfo(HttpServletRequest request) {
		List retrunList = new ArrayList() ;
		AdminBean admin=SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CPNY_ID", admin.getCpnyId());
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = loginSupplierAdminDao.getLoginSupplierAdminInfo(paramMap , 
				NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
				NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
			) ;
		}
		else{
			retrunList = loginSupplierAdminDao.getLoginSupplierAdminInfo(paramMap) ;
		}
		return retrunList ;
	}

	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String updateLoginSupplierAdminInfo(HttpServletRequest request) {
		// session用户信息 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("UPDATED_BY", admin.getAdminID()) ;
		// 权限组信息
		String screenGrantID = "" ;
		String[] screenGrantIDs = request.getParameterValues("SCREEN_GRANT_ID") ;
		if(screenGrantIDs!=null){
			for(int i = 0 ; i < screenGrantIDs.length ; ++i){
				screenGrantID+= screenGrantIDs[i] ;
				if (i != screenGrantIDs.length - 1){
					screenGrantID+="," ;
				}
			}
		}
		paramMap.put("SCREEN_GRANT_ID", screenGrantID) ;
		
		return this.loginSupplierAdminDao.updateLoginSupplierAdminInfo(paramMap) ;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String deleteLoginSupplierAdminInfo(HttpServletRequest request) {
		Map pamaMap = ObjectBindUtil.getRequestParamData(request);
		return this.loginSupplierAdminDao.deleteLoginSupplierAdminInfo(pamaMap);
	}

	//@Override
	@SuppressWarnings({ "rawtypes", "unchecked", })
	@Override
	public int getLoginSupplierAdminInfoCnt(HttpServletRequest request) {
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		AdminBean admin=SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		return loginSupplierAdminDao.getLoginSupplierAdminInfoCnt(paramMap) ;
	}

	@SuppressWarnings({ "rawtypes", "unchecked", })
	@Override
	public List getLoginSupplierAdminDeptInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return loginSupplierAdminDao.getLoginSupplierAdminDeptInfo(paramMap) ;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked", })
	@Override
	public List getRolesSelectList(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return loginSupplierAdminDao.getRolesSelectList(paramMap) ;
	}
	
}
