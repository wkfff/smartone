package com.siping.pa.service.imp;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.PaBasicDao;
import com.siping.pa.service.PaBasicSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PaBasicSerImp implements PaBasicSer {

	Logger logger = Logger.getLogger(PaBasicSerImp.class);
	
	@Autowired
	private PaBasicDao paBasicDao;

	@SuppressWarnings("rawtypes")
	public List getPaSearchEmployeeList(HttpServletRequest request) {
		List retrunList = new ArrayList() ;
		
		// 页面提交数据
		LinkedHashMap paramMap = this.setGetPaSearchEmployeeListParam(request) ;

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = 
				paBasicDao.getPaSearchEmployeeList(paramMap , 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class), 
							NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class) 
						) ;
		}
		else{
			retrunList = paBasicDao.getPaSearchEmployeeList(paramMap) ;
		}
		
		return retrunList ;
	}

	@SuppressWarnings("rawtypes")
	public int getPaSearchEmployeeCnt(HttpServletRequest request) {
		int retrunInt = 0 ;
		 
		
		// 页面提交数据
		LinkedHashMap paramMap = this.setGetPaSearchEmployeeListParam(request) ;

		retrunInt = paBasicDao.getPaSearchEmployeeCnt(paramMap) ;
		
		return retrunInt ;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private LinkedHashMap setGetPaSearchEmployeeListParam(HttpServletRequest request){
		// 从session中取得登陆用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("PA_ADMIN_ID", ObjectUtils.toString(admin.getAdminID())) ;
		
		return paramMap ;
	}
	
}
