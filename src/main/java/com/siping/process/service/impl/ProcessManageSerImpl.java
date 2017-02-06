package com.siping.process.service.impl;
 
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 
import org.springframework.util.NumberUtils;

import com.siping.ess.dao.EssAppCheckDao;
import com.siping.process.dao.ProcessManageDao;
import com.siping.process.service.ProcessManageSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;
import com.siping.web.utility.dao.UtilityOtherInfoDao;

@Service
public class ProcessManageSerImpl implements ProcessManageSer {

	Logger logger = Logger.getLogger(ProcessManageSerImpl.class);

	@Autowired
	private ProcessManageDao processManageDao;

	@Autowired
	private UtilityOtherInfoDao utilityOtherInfoDao;



	/**
	 * 获取审核者的审核结果 (non-Javadoc)
	 * 
	 * @see com.siping.ess.service.InfoAppSer#getAffirmorList(javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAffirmorResultList(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map param = ObjectBindUtil.getRequestParamData(request);
		param.put("language", Messages.getLanguage(request)); 
		param.put("CPNY_ID", admin.getCpnyId()); 
		return this.processManageDao.getAffirmorResultList(param);
	}

	/**
	 * 获取审核者 (non-Javadoc)
	 * 
	 * @see com.siping.ess.service.InfoAppSer#getAffirmorList(javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAffirmorList(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map param = ObjectBindUtil.getRequestParamData(request);
		param.put("language", Messages.getLanguage(request)); 
		if (param.get("EMPID") == null || param.get("EMPID").equals("")) {
			param.put("EMPID", admin.getAdminID());
		}
		return this.processManageDao.getAffirmorList(param);
	}

	
	/**
	 * 创建对象申请 (non-Javadoc)
	 * 
	 * @see com.siping.ess.service.InfoAppSer#addObjectApp(javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map addObjectApp(HttpServletRequest request) {
		Map returnMap = new LinkedHashMap<Object, Object>();

		try {
			AdminBean admin = SessionUtil.getLoginUserFromSession(request);
			Map param = ObjectBindUtil.getRequestParamData(request);
			param.put("CREATED_BY", admin.getAdminID());
			param.put("CPNY_ID", admin.getCpnyId());
			
			List affirmorList= this.getAffirmorList(request);
			if(affirmorList.size()==0){
			
			}else{
				param.put("affirmorList", affirmorList);
				this.processManageDao.addObjectApp(param,true);
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
			returnMap.put("errcode", new Integer(1));
			returnMap.put("errmsg", e.toString());
		}
		return returnMap;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmObjectInfo(HttpServletRequest request)
			{
		Map returnMap = new LinkedHashMap<Object, Object>();
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		paramMap.put("adminID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request)); 
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			returnMap = this.processManageDao.getAffirmObjectInfo(paramMap,
					NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")),Integer.class), 
					NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
		} else { 
			returnMap = this.processManageDao.getAffirmObjectInfo(paramMap);
		}  
		return returnMap;
	}
	
	/**
	 * 审批申请
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Map affirmApp(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request); 
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("AFFIRMOR_ID", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
		
		return this.processManageDao.affirmObjectApp(updateList);
	}

	@Override
	public String saveAndUpdateRejectStatus(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>() ;
		appendMap.put("UPDATED_BY", admin.getAdminID()) ;	
		appendMap.put("CREATED_BY", admin.getAdminID()) ;
		appendMap.put("CPNY_ID", admin.getCpnyId()) ;
		String jsonString = request.getParameter("jsonData") ;		
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap) ;
		this.processManageDao.updateObjectListStatus(updateList);
		this.addObjectListApp(updateList);
		return "Y";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void addObjectListApp(List list){
		//To be debug
		for(Object obj : list){
			Map param = (Map)obj;
			//getAffirmorList 的SQL有问题
			param.put("affirmorList", this.processManageDao.getAffirmorList(obj));
			this.processManageDao.addObjectApp(param,true);			
		}
	}
}
