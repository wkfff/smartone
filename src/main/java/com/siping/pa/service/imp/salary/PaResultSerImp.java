package com.siping.pa.service.imp.salary;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.pa.dao.salary.PaItemDao;
import com.siping.pa.dao.salary.PaInputItemDao;
import com.siping.pa.dao.salary.PaResultDao;
import com.siping.pa.service.salary.PaResultSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.dao.UtilityOtherInfoDao;

@Service
public class PaResultSerImp implements PaResultSer {

	Logger logger = Logger.getLogger(PaResultSerImp.class);
	
	@Autowired
	private PaResultDao paResultDao ;
	
	@Autowired
	private PaItemDao paItemDao ;
	
	@Autowired
	private PaInputItemDao paInputItemDao ;
	
	@Autowired
	private UtilityOtherInfoDao utilityOtherInfoDao ;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getPaResultAllItem(HttpServletRequest request){
		
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		
		//计算项目
		List paItemList = this.paItemDao.getPaItemInfo(paramMap) ;
		//输入项目
		List paInputItemList = this.paInputItemDao.getPaInputItemInfo(paramMap) ;
		
		//人事项目
		paramMap.put("TABLE_NAME", "PA_HR_V") ;
		List hrItemList = new ArrayList() ;
		LinkedHashMap tMap = new LinkedHashMap() ;
		tMap.put("DISTINCT_FIELD", "PA_MONTH") ;
		tMap.put("FIELD_NAME", "工资月") ;
		hrItemList.add(tMap) ;
		hrItemList.addAll(this.utilityOtherInfoDao.getMCSelectList(paramMap)) ;
		
		//考勤项目
		paramMap.put("TABLE_NAME", "PA_AR_V") ;
		List arItemList = this.utilityOtherInfoDao.getMCSelectList(paramMap) ;
		
		//
		LinkedHashMap itemMap = new LinkedHashMap() ;
		itemMap.put("paItemList", paItemList) ;
		itemMap.put("paInputItemList", paInputItemList) ;
		itemMap.put("hrItemList", hrItemList) ;
		itemMap.put("arItemList", arItemList) ;
		
		return itemMap ;
	}
	 
	@SuppressWarnings("rawtypes")
	public String paBalance(HttpServletRequest request) {
		String returnString = "" ;
				
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;

		returnString = paResultDao.paBalance(paramMap) ;
		
		return returnString ;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List getPaColumns(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.paResultDao.getPaColumns(paramMap);
	}
}
