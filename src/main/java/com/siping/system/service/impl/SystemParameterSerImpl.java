package com.siping.system.service.impl;

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

import com.siping.system.bean.AdminBean; 
import com.siping.system.dao.SystemParameterDao; 
import com.siping.system.service.SystemParameterSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class SystemParameterSerImpl implements SystemParameterSer {
	Logger logger = Logger.getLogger(SystemParameterSerImpl.class);

	@Autowired
	private SystemParameterDao systemParameterDao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemParameterSer#getModuleParameterInfo(javax
	 * .servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getModuleParameterInfo(HttpServletRequest request) { 
		
		List retrunList = new ArrayList(); 
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));  
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.systemParameterDao.getModuleParameterInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.systemParameterDao.getModuleParameterInfo(paramMap);
		}
		
		return retrunList;
	}  
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getModuleParameterInfoCnt(HttpServletRequest request) {
 
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request)); 
		  
		return this.systemParameterDao.getModuleParameterInfoCnt(paramMap);
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemParameterSer#addModuleParameterInfo
	 * (javax .servlet.http.HttpServletRequest)
	 */
	public int addModuleParameterInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("CREATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);

		return this.systemParameterDao.addModuleParameterInfo(insertList);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#updatePageStructureInfo
	 * (javax .servlet.http.HttpServletRequest)
	 */
	public int updateModuleParameterInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);

		return this.systemParameterDao.updateModuleParameterInfo(updateList);
	}
	@Override
	public String saveAmdUpdateModuleParameterInfo(HttpServletRequest request) {
		String result = "Y";
		int add = this.addModuleParameterInfo(request);
		int update = this.updateModuleParameterInfo(request);
		if (add+update == 2) {
			result = "Y";
		}else {
			result = "数据保存出错，请重新保存！";
		}
		return result;
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#deleteModuleParameterInfo(
	 * javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes" })
	public String deleteModuleParameterInfo(HttpServletRequest request) {

		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return systemParameterDao.deleteModuleParameterInfo(paramMap);
	}
 
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemParameterSer#getLeaveAppParameterInfo(javax
	 * .servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getLeaveAppParameterInfo(HttpServletRequest request) { 
		
		List retrunList = new ArrayList(); 
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));  
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.systemParameterDao.getLeaveAppParameterInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.systemParameterDao.getLeaveAppParameterInfo(paramMap);
		}
		
		return retrunList;
	}  
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getLeaveAppParameterInfoCnt(HttpServletRequest request) {
 
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request)); 
		  
		return this.systemParameterDao.getLeaveAppParameterInfoCnt(paramMap);
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemParameterSer#addLeaveAppParameterInfo
	 * (javax .servlet.http.HttpServletRequest)
	 */
	public int addLeaveAppParameterInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("CREATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);

		return this.systemParameterDao.addLeaveAppParameterInfo(insertList);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#updatePageStructureInfo
	 * (javax .servlet.http.HttpServletRequest)
	 */
	public int updateLeaveAppParameterInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);

		return this.systemParameterDao.updateLeaveAppParameterInfo(updateList);
	}
	@Override
	public String saveAndUpdateLeaveAppParameterInfo(HttpServletRequest request) {
		String result = "Y";
		int add = this.addLeaveAppParameterInfo(request);
		int update = this.updateLeaveAppParameterInfo(request);
		if (add+update == 2) {
			result = "Y";
		}else {
			result = "数据保存出错，请重新保存！";
		}
		return result;
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#deleteLeaveAppParameterInfo(
	 * javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes" })
	public String deleteLeaveAppParameterInfo(HttpServletRequest request) {

		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return systemParameterDao.deleteLeaveAppParameterInfo(paramMap);
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemParameterSer#getOTAppParameterInfo(javax
	 * .servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getOTAppParameterInfo(HttpServletRequest request) { 
		
		List retrunList = new ArrayList(); 
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));  
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.systemParameterDao.getOTAppParameterInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.systemParameterDao.getOTAppParameterInfo(paramMap);
		}
		
		return retrunList;
	}  
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getOTAppParameterInfoCnt(HttpServletRequest request) {
 
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request)); 
		  
		return this.systemParameterDao.getOTAppParameterInfoCnt(paramMap);
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemParameterSer#addOTAppParameterInfo
	 * (javax .servlet.http.HttpServletRequest)
	 */
	public int addOTAppParameterInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("CREATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);

		return this.systemParameterDao.addOTAppParameterInfo(insertList);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#updateOTAppParameterInfo
	 * (javax .servlet.http.HttpServletRequest)
	 */
	public int updateOTAppParameterInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);

		return this.systemParameterDao.updateOTAppParameterInfo(updateList);
	}
	@Override
	public String saveAndUpdateOTAppParameterInfo(HttpServletRequest request) {
		String result = "Y";
		int add = this.addOTAppParameterInfo(request);
		int update = this.updateOTAppParameterInfo(request);
		if (add+update == 2) {
			result = "Y";
		}else {
			result = "数据保存出错，请重新保存！";
		}
		return result;
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.service.SystemPageStructureSer#deleteOTAppParameterInfo(
	 * javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes" })
	public String deleteOTAppParameterInfo(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		return systemParameterDao.deleteOTAppParameterInfo(paramMap);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getSliceTypeParameter(HttpServletRequest request) {
		List retrunList = new ArrayList(); 
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));  
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.systemParameterDao.getSliceTypeParameter(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.systemParameterDao.getSliceTypeParameter(paramMap);
		}
		
		return retrunList;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getSliceTypeParameterCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request)); 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		  
		return this.systemParameterDao.getSliceTypeParameterCnt(paramMap);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getSliceTypeDetail(HttpServletRequest request) {
		List retrunList = new ArrayList(); 
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));  
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.systemParameterDao.getSliceTypeDetail(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.systemParameterDao.getSliceTypeDetail(paramMap);
		}
		
		return retrunList;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getSliceTypeDetailCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request)); 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		  
		return this.systemParameterDao.getSliceTypeDetailCnt(paramMap);
	}
	@Override
	public int addSliceTypeParameter(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("CREATE_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);

		return this.systemParameterDao.addSliceTypeParameter(insertList);
	}
	@Override
	public int updateSliceTypeParameter(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);

		return this.systemParameterDao.updateSliceTypeParameter(updateList);
	}
	@Override
	public String saveAndUpdateSliceParameter(HttpServletRequest request) {
		String result = "Y";
		int add = this.addSliceTypeParameter(request);
		int update = this.updateSliceTypeParameter(request);
		if (add+update == 2) {
			result = "Y";
		}else {
			result = "数据保存出错，请重新保存！";
		}
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String deleteSliceTypeParameter(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return systemParameterDao.deleteSliceTypeParameter(paramMap);
	}
	@Override
	public int addSliceTypeDetail(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("CREATE_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
		String parameterNo = request.getParameter("PARAMETER_NO");
		appendMap.put("PARAMETER_NO", parameterNo);

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);

		return this.systemParameterDao.addSliceTypeDetail(insertList);
	}
	@Override
	public int updateSliceTypeDetail(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");
		String parameterNo = request.getParameter("PARAMETER_NO");
		appendMap.put("PARAMETER_NO", parameterNo);

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);

		return this.systemParameterDao.updateSliceTypeDetail(updateList);
	}
	@Override
	public String saveAndUpdateSliceTypeDetail(HttpServletRequest request) {
		String result = "Y";
		int add = this.addSliceTypeDetail(request);
		int update = this.updateSliceTypeDetail(request);
		if (add+update == 2) {
			result = "Y";
		}else {
			result = "数据保存出错，请重新保存！";
		}
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String deleteSliceTypeDetail(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		return systemParameterDao.deleteSliceTypeDetail(paramMap);
	}
}
