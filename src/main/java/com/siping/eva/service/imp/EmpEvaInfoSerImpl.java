package com.siping.eva.service.imp;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;
 
import com.siping.eva.dao.EmpEvaInfoDao;
import com.siping.eva.service.EmpEvaInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class EmpEvaInfoSerImpl implements EmpEvaInfoSer {

	Logger logger = Logger.getLogger(EmpEvaInfoSerImpl.class);

	@Autowired
	private EmpEvaInfoDao empEvaInfoDao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#getEvaEmpWorkInfo(javax.servlet.http
	 * .HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getEvaEmpWorkInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		try {
			paramMap.put("language", Messages.getLanguage(request));
			paramMap.put("HR_ADMIN_ID", admin.getAdminID());
			paramMap.put("CPNY_ID", admin.getCpnyId());
			if (paramMap.get("page") != null
					&& paramMap.get("pagesize") != null) {
				retrunList = this.empEvaInfoDao.getEvaEmpWorkInfo(paramMap,
						NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("pagesize")),
								Integer.class));
			} else {
				retrunList = this.empEvaInfoDao.getEvaEmpWorkInfo(paramMap);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retrunList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#getEvaEmpWorkInfoCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getEvaEmpWorkInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.empEvaInfoDao.getEvaEmpWorkInfoCnt(paramMap);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#saveAndUpdateEvaEmpWorkInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String saveAndUpdateEvaEmpWorkInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);
  
		if(insertList.size()>0){
			this.empEvaInfoDao.addEvaEmpWorkInfo(insertList);
			paramMap.remove("jsonData");
			if(this.empEvaInfoDao.checkEvaEmpEveInfo(paramMap) == 0){
				this.empEvaInfoDao.addEvaEmpEveInfo(paramMap);
			}
		}
		if(updateList.size()>0){
			this.empEvaInfoDao.updateEvaEmpWorkInfo(updateList);
		} 
		return "Y";
	}


	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#updateEvaEmpOngoingWorkInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	public String updateEvaEmpOngoingWorkInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
 
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,"update", appendMap);
   
		if(updateList.size()>0){
			this.empEvaInfoDao.updateEvaEmpOngoingWorkInfo(updateList);
		} 
		return "Y";
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#updateEssEmpOngoingWorkInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String updateEssEmpOngoingWorkInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
 
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,"update", appendMap);
   
		if(updateList.size()>0){
			this.empEvaInfoDao.updateEssEmpOngoingWorkInfo(updateList);
		} 
		paramMap.remove("jsonData");
		this.empEvaInfoDao.updateEssWorkFlagInfo(paramMap);
		return "Y";
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#deleteEvaEmpWorkInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int deleteEvaEmpWorkInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.empEvaInfoDao.deleteEvaEmpWorkInfo(paramMap);
	}  
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#getEvaEmpItemInfo(javax.servlet.http
	 * .HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getEvaEmpItemInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		try {
			paramMap.put("language", Messages.getLanguage(request));
			paramMap.put("HR_ADMIN_ID", admin.getAdminID());
			paramMap.put("CPNY_ID", admin.getCpnyId());
			if (paramMap.get("page") != null
					&& paramMap.get("pagesize") != null) {
				retrunList = this.empEvaInfoDao.getEvaEmpItemInfo(paramMap,
						NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("pagesize")),
								Integer.class));
			} else {
				retrunList = this.empEvaInfoDao.getEvaEmpItemInfo(paramMap);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retrunList;
	}  
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#getEvaEmpEveInfo(javax.servlet.http
	 * .HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getEvaEmpEveInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		try { 
			paramMap.put("language", Messages.getLanguage(request)); 
			retrunList = this.empEvaInfoDao.getEvaEmpEveInfo(paramMap);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retrunList;
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#getEvaEmpItemInfoCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getEvaEmpItemInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.empEvaInfoDao.getEvaEmpItemInfoCnt(paramMap);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#saveAndUpdateEvaEmpItemInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String saveAndUpdateEvaEmpItemInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);
  
		if(insertList.size()>0){
			this.empEvaInfoDao.addEvaEmpItemInfo(insertList);
			paramMap.remove("jsonData");
			if(this.empEvaInfoDao.checkEvaEmpEveInfo(paramMap) == 0){
				this.empEvaInfoDao.addEvaEmpEveInfo(paramMap);
			}
		}
		if(updateList.size()>0){
			this.empEvaInfoDao.updateEvaEmpItemInfo(updateList);
		} 
		return "Y";
	}  
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#updateEvaEmpOngoingItemInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String updateEvaEmpOngoingItemInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
  
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,"update", appendMap);
   
		if(updateList.size()>0){
			this.empEvaInfoDao.updateEvaEmpOngoingItemInfo(updateList);
		} 
		paramMap.remove("jsonData"); 
		this.empEvaInfoDao.updateEvaItemFlagInfo(paramMap);
		return "Y";
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#updateEssEmpOngoingItemInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String updateEssEmpOngoingItemInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
  
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,"update", appendMap);
   
		if(updateList.size()>0){
			this.empEvaInfoDao.updateEssEmpOngoingItemInfo(updateList);
		} 
		paramMap.remove("jsonData");
		this.empEvaInfoDao.updateEssItemFlagInfo(paramMap);
		return "Y";
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.EmpEvaInfoSer#deleteEvaEmpItemInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int deleteEvaEmpItemInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.empEvaInfoDao.deleteEvaEmpItemInfo(paramMap);
	}  
	/**
	 * 获取信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		return paramMap;
	}
}
