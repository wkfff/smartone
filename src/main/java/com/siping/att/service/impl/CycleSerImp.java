package com.siping.att.service.impl;

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

import com.siping.att.dao.CycleDao;
import com.siping.att.service.CycleSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class CycleSerImp implements CycleSer {

	Logger logger = Logger.getLogger(CycleSerImp.class);
	
	@Autowired
	private CycleDao cycleDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getCycleInfo(HttpServletRequest request) {
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language", Messages.getLanguage(request));
		
		return this.cycleDao.getCycleInfo(paramMap) ; 
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getCycleInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList() ;
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = 
					this.cycleDao.getCycleInfoList(paramMap , 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
						) ;
		}
		else{
			retrunList = this.cycleDao.getCycleInfoList(paramMap);
		}
		
		return retrunList ;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int addCycleInfo(HttpServletRequest request){

		// session用户信息 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;

		paramMap.put("CREATED_BY", admin.getAdminID()) ;
		
		this.cycleDao.addCycleInfo(paramMap) ;
		
		return 0 ;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int updateCycleInfo(HttpServletRequest request) {

		// session用户信息 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("UPDATE_BY", admin.getAdminID()) ;
		
		this.cycleDao.updateCycleInfo(paramMap) ;
		
		return 0 ;
	}
	 
	@SuppressWarnings("rawtypes")
	public int deleteCycleInfo(HttpServletRequest request) {
		
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		
		this.cycleDao.deleteCycleInfo(paramMap) ;
		
		return 0 ;
	}

	@SuppressWarnings({ "rawtypes" })
	public int getCycleInfoCnt(HttpServletRequest request) {
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		
		return cycleDao.getCycleInfoCnt(paramMap) ;
	}
}
