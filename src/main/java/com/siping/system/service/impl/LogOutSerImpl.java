package com.siping.system.service.impl;
 
import java.util.LinkedHashMap; 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Service; 

import com.siping.system.bean.AdminBean;
import com.siping.system.dao.LogOutDao; 
import com.siping.system.service.LogOutSer; 
import com.siping.web.utility.SessionUtil; 

@Service
public class LogOutSerImpl implements LogOutSer {
	
	Logger logger = Logger.getLogger(LogOutSerImpl.class);
	
	@Autowired  
	private LogOutDao logOutDao;
	/**
	 * 退出登录 修改信息
	 * (non-Javadoc)
	 * @see com.siping.system.service.LogOutSer#updateUserInfo(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked", })
	@Override
	public void updateUserInfo(HttpServletRequest request,HttpServletResponse response){ 
		AdminBean user = (AdminBean) SessionUtil.getLoginUserFromSession(request); 
		if (user!=null){ 
			logger.info("UserName:" + user.getUsername()); 
			LinkedHashMap info = new LinkedHashMap();
			info.put("empid", user.getAdminID());  
			logOutDao.updateLoginInfo(info); 
		}
		
	} 
}
