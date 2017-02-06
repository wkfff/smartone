package com.siping.att.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.att.dao.AttDaliyLockDao; 
import com.siping.att.dao.AttProgressDao;
import com.siping.att.service.AttProgressSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttProgressSerImp implements AttProgressSer {
	Logger logger = Logger.getLogger(AttProgressSerImp.class);
	
	@Autowired
	private AttProgressDao attProgressDao;
	@Autowired
	private AttDaliyLockDao attDaliyLockDao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getAttProgressInfo(HttpServletRequest request) {
		 
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		String arMonth = ObjectUtils.toString(paramMap.get("arMonth")) ;
		if(arMonth.length() == 0){
			arMonth = DateUtil.getSysdateString("yyyyMM") ;
			paramMap.put("arMonth", arMonth) ;
		}
		return attProgressDao.getAttProgressInfo(paramMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int updateAttProgressInfo(HttpServletRequest request){
		
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("UPDATED_BY", admin.getAdminID()) ; 
		this.attDaliyLockDao.updateAttDaliyLockInfo(paramMap);
		this.attProgressDao.updateAttProgressInfo(paramMap) ;
		
		return 0 ;
	}
	
	
}
