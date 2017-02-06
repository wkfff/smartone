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
import com.siping.web.utility.service.UtilityProdInfoSer;
import com.siping.web.utility.dao.*;

@Service
public class UtilityProdInfoSerImpl implements UtilityProdInfoSer {

	Logger logger = Logger.getLogger(UtilityProdInfoSer.class);
	@Autowired
	private UtilityProdInfoDao utilityProdInfoDao;
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getProductList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CHANNEL_ID", admin.getChannelID());
		if(paramMap==null||paramMap.get("type")==null){
			return this.utilityProdInfoDao.getProductList(paramMap);
		}
		if(paramMap.get("type").toString().equals("basic")){
			return this.utilityProdInfoDao.getBasicProductList(paramMap);
		}else if(paramMap.get("type").toString().equals("storage")){
			return this.utilityProdInfoDao.getStorageList(paramMap);
		}else{
			return this.utilityProdInfoDao.getProductList(paramMap);
		}
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int getProductListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);		
		if(paramMap==null||paramMap.get("type")==null){
			return this.utilityProdInfoDao.getProductListCnt(paramMap);
		}
		if(paramMap.get("type").toString().equals("basic")){
			return this.utilityProdInfoDao.getBasicProductListCnt(paramMap);
		}else if(paramMap.get("type").toString().equals("storage")){
			return this.utilityProdInfoDao.getStorageListCnt(paramMap);
		}else{
			return this.utilityProdInfoDao.getProductListCnt(paramMap);
		}
	}
}
