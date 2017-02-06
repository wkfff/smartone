package com.siping.pa.service.imp.salary;

import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.pa.dao.salary.PaHistoryDao;
import com.siping.pa.service.salary.PaHistorySer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PaHistorySerImp implements PaHistorySer {

	Logger logger = Logger.getLogger(PaHistorySerImp.class);
	
	@Autowired
	private PaHistoryDao paHistoryDao;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getCheckPaHistoryFlag(HttpServletRequest request) {
		int retrunInt = 0 ;
		// 从session中取得登陆用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;

		retrunInt = paHistoryDao.getCheckPaHistoryFlag(paramMap) ;
		
		return retrunInt ;
	}
}
