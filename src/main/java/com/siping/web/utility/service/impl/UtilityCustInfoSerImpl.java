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
import com.siping.web.utility.service.UtilityCustInfoSer;
import com.siping.web.utility.service.UtilityProdInfoSer;

@Service
public class UtilityCustInfoSerImpl implements UtilityCustInfoSer{
	
	Logger logger = Logger.getLogger(UtilityProdInfoSer.class);
	@Autowired
	private UtilityCustInfoDao utilityCustInfoDao;
	
	@Autowired
	private SalesSettingSer salesSettingSer;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getCustomerList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        if (paramMap.get("EMP_ID")==null||paramMap.get("EMP_ID")==""){
		    paramMap.put("EMP_ID", admin.getAdminID());
        }
		paramMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
		//移动端判断客户用
        if(request.getAttribute("CUST_ID")!=null && !"".equals(request.getAttribute("CUST_ID"))){
            paramMap.put("CUST_ID", request.getAttribute("CUST_ID"));
        }
        //移动端如何是客户登陆的就不要要这个了不然查不出来
        if(admin.getAccountType()!=null && "CU".equals(admin.getAccountType())){
            paramMap.put("isSupervisor", "");
        }
		return this.utilityCustInfoDao.getCustomerList(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getCustomerListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);	
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("EMP_ID", admin.getAdminID());
		paramMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
		return this.utilityCustInfoDao.getCustomerListCnt(paramMap);
	}
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getAllCustomerList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);	
		
		return this.utilityCustInfoDao.getCustomerList(paramMap);
	}

	@SuppressWarnings({"rawtypes" })
	@Override
	public int getAllCustomerListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);	
		
		return this.utilityCustInfoDao.getCustomerListCnt(paramMap);
	}	
}
