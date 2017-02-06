package com.siping.cust.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.cust.dao.SalesSettingDao;
import com.siping.cust.service.SalesSettingSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class SalesSettingSerImpl implements SalesSettingSer {
	Logger logger = Logger.getLogger(SalesSettingSer.class);
	@Autowired
	private SalesSettingDao salesSettingDao;
	
	@SuppressWarnings({ "rawtypes"})
	@Override
	public List getSalesKeeperList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.salesSettingDao.getSalesKeeperList(paramMap);
	}

	@SuppressWarnings({"rawtypes" })
	@Override
	public int getSalesKeeperListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);	
		return this.salesSettingDao.getSalesKeeperListCnt(paramMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Object getSalesKeeperDetail(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		return this.salesSettingDao.getSalesKeeperDetail(paramMap);
	}
	
	@SuppressWarnings({"rawtypes","unchecked"})
	@Override
	public String removeSalesKeeper(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		
		String resultStr = "Y";
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		try{
			this.salesSettingDao.removeSalesKeeperInfo(paramMap);
			this.salesSettingDao.removeSalesKeeper(paramMap);
		}catch(SQLException e)
		{
			resultStr = e.getMessage();
			e.printStackTrace();
		}
		return resultStr;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getSalesKeeperDeptInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		retrunList = salesSettingDao.getSalesKeeperDeptInfo(paramMap);
		return retrunList;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void transferSalesKeeper(HttpServletRequest request) throws SQLException {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CREATED_BY", admin.getAdminID()); 
		paramMap.put("UPDATED_BY", admin.getAdminID()); 
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString);
		Object type = paramMap.get("type");
		if(type.equals("add")){
			if(this.isSupervisor(request))
				return;
			this.salesSettingDao.addSalesKeeperInfo(updateList);
			this.salesSettingDao.addSalesKeeper(paramMap);
		}
		if(type.equals("update")){
			this.salesSettingDao.removeSalesKeeperInfo(paramMap);
			this.salesSettingDao.addSalesKeeperInfo(updateList);
			this.salesSettingDao.updateSalesKeeper(paramMap);
		}	
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public boolean isSupervisor(HttpServletRequest request){
		boolean isSupervisor = false;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		if(paramMap.get("EMP_ID")==null||paramMap.get("EMP_ID")=="")
			paramMap.put("EMP_ID", admin.getAdminID());
		isSupervisor = (salesSettingDao.getRecordCount(paramMap)>0);
		return isSupervisor;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getDirectSalesList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.salesSettingDao.getDirectSalesList(paramMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int getDirectSalesListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.salesSettingDao.getDirectSalesListCnt(paramMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getNetworkSalesList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.salesSettingDao.getNetworkSalesList(paramMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int getNetworkSalesListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.salesSettingDao.getNetworkSalesListCnt(paramMap);
	}
	
	@Override
	public void transferDirectSales(HttpServletRequest request) throws SQLException{
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);
		if (insertList.size() > 0) {
			this.salesSettingDao.addDirectSales(insertList);
		}
		if (updateList.size() > 0) {
			this.salesSettingDao.updateDirectSales(updateList);
		}
	}
	
	@Override
	public void transferNetworkSales(HttpServletRequest request) throws SQLException{
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);
		if (insertList.size() > 0) {
			this.salesSettingDao.addNetworkSales(insertList);
		}
		if (updateList.size() > 0) {
			this.salesSettingDao.updateNetworkSales(updateList);
		}
	}
	
	@SuppressWarnings({"rawtypes","unchecked"})
	@Override
	public String removeDirectSales(HttpServletRequest request) throws SQLException {
		String resultStr = "Y";
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		this.salesSettingDao.removeDirectSales(paramMap);
		return resultStr;
	}
	
}
