package com.siping.system.service.impl;

import java.util.ArrayList; 
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
 
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 
import org.springframework.util.NumberUtils;
 
import com.siping.system.bean.AdminBean;
import com.siping.system.dao.SystemMenuDao;
import com.siping.system.service.SystemMenuSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class SystemMenuSerImp implements SystemMenuSer {

	Logger logger = Logger.getLogger(SystemMenuSerImp.class);
	
	@Autowired
	private SystemMenuDao systemMenuDao ;
  
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getSystemMenuInfo(HttpServletRequest request) {
		List retrunList = new ArrayList() ; 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
 
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = 
					this.systemMenuDao.getSystemMenuInfo(paramMap , 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
						) ;
		}
		else{
			retrunList = this.systemMenuDao.getSystemMenuInfo(paramMap) ;
		}
		return retrunList ;
	}
	//@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getSystemMenuInfoCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		Map paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("language",Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.systemMenuDao.getSystemMenuInfoCnt(paramMap) ;
	}
}
