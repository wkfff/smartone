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
import com.siping.system.dao.LoginSupplierDao;
import com.siping.system.service.LoginSupplierSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class LoginSupplierSerImp implements LoginSupplierSer {

	Logger logger = Logger.getLogger(LoginSupplierSerImp.class);
	
	@Autowired
	private LoginSupplierDao loginSupplierDao;
	
	@Autowired
	private TransferOrderDao transferOrderDao;
	
	@SuppressWarnings({ "rawtypes" })
	@Override
	public Object getLoginSupplierInfoObj(HttpServletRequest request) {
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		
		return this.loginSupplierDao.getLoginSupplierInfoObj(paramMap) ; 
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getLoginSupplierRolesGroupList(HttpServletRequest request){

		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		
		return this.loginSupplierDao.getLoginSupplierRolesGroupList(paramMap) ; 
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getLoginSupplierInfo(HttpServletRequest request) {
		List retrunList = new ArrayList() ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = loginSupplierDao.getLoginSupplierInfo(paramMap , 
				NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
				NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
			) ;
		}
		else{
			retrunList = loginSupplierDao.getLoginSupplierInfo(paramMap) ;
		}
		return retrunList ;
	}

	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	@Override
	public String addLoginSupplierInfo(HttpServletRequest request){
		String resultString ="Y";
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		if(this.transferOrderDao.checkEmpID(paramMap) == 0){
			return "系统中没有此工号对应的人员";
		}
		if(this.loginSupplierDao.checkAdminID(paramMap) != 0){
			return "此此账号已被使用";
		}
		try{
			paramMap.put("PASSWORD",EncryptUtil.MD5Encode("123456"));
			resultString = this.loginSupplierDao.addLoginSupplierInfo(paramMap);
		}catch(SQLException e){
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return "Y";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String updateLoginSupplierInfo(HttpServletRequest request) {
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
		
		return this.loginSupplierDao.updateLoginSupplierInfo(paramMap) ;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String deleteLoginSupplierInfo(HttpServletRequest request) {
		Map pamaMap = ObjectBindUtil.getRequestParamData(request);
		return this.loginSupplierDao.deleteLoginSupplierInfo(pamaMap);
	}

	//@Override
	@SuppressWarnings({ "rawtypes", })
	@Override
	public int getLoginSupplierInfoCnt(HttpServletRequest request) {
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		
		return loginSupplierDao.getLoginSupplierInfoCnt(paramMap) ;
	}

	@SuppressWarnings({ "rawtypes", "unchecked", })
	@Override
	public List getLoginSupplierDeptInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return loginSupplierDao.getLoginSupplierDeptInfo(paramMap) ;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked", })
	@Override
	public List getRolesSelectList(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return loginSupplierDao.getRolesSelectList(paramMap) ;
	}
	
}
