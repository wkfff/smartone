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

import com.siping.eva.dao.BasicInfoDao;
import com.siping.eva.service.BasicInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class BasicInfoSerImpl implements BasicInfoSer {

	Logger logger = Logger.getLogger(BasicInfoSerImpl.class);

	@Autowired
	private BasicInfoDao basicInfoDao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.BasicInfoSer#getEvaPeriodInfo(javax.servlet.http
	 * .HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getEvaPeriodInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		try {
			paramMap.put("language", Messages.getLanguage(request));
			paramMap.put("AR_ADMIN_ID", admin.getAdminID());
			paramMap.put("CPNY_ID", admin.getCpnyId());
			if (paramMap.get("page") != null
					&& paramMap.get("pagesize") != null) {
				retrunList = this.basicInfoDao.getEvaPeriodInfo(paramMap,
						NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("pagesize")),
								Integer.class));
			} else {
				retrunList = this.basicInfoDao.getEvaPeriodInfo(paramMap);
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
	 * com.siping.eva.service.BasicInfoSer#getEvaPeriodInfoCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getEvaPeriodInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.basicInfoDao.getEvaPeriodInfoCnt(paramMap);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.BasicInfoSer#saveAndUpdateEvaPeriodInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	public String saveAndUpdateEvaPeriodInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

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
			this.basicInfoDao.addEvaPeriodInfo(insertList);
		}
		if(updateList.size()>0){
			this.basicInfoDao.updateEvaPeriodInfo(updateList);
		} 
		return "Y";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.BasicInfoSer#deleteEvaPeriodInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int deleteEvaPeriodInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.basicInfoDao.deleteEvaPeriodInfo(paramMap);
	} 
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.BasicInfoSer#getEvaPeriodTypeInfo(javax.servlet.http
	 * .HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getEvaPeriodTypeInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		try {
			paramMap.put("language", Messages.getLanguage(request));
			paramMap.put("AR_ADMIN_ID", admin.getAdminID());
			paramMap.put("CPNY_ID", admin.getCpnyId());
			if (paramMap.get("page") != null
					&& paramMap.get("pagesize") != null) {
				retrunList = this.basicInfoDao.getEvaPeriodTypeInfo(paramMap,
						NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("pagesize")),
								Integer.class));
			} else {
				retrunList = this.basicInfoDao.getEvaPeriodTypeInfo(paramMap);
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
	 * com.siping.eva.service.BasicInfoSer#getEvaPeriodTypeInfoCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getEvaPeriodTypeInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.basicInfoDao.getEvaPeriodTypeInfoCnt(paramMap);
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.BasicInfoSer#saveAndUpdateEvaPeriodTypeInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	public String saveAndUpdateEvaPeriodTypeInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID()); 

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);
 
		if(insertList.size()>0){
			this.basicInfoDao.addEvaPeriodTypeInfo(insertList);
		}
		if(updateList.size()>0){
			this.basicInfoDao.updateEvaPeriodTypeInfo(updateList);
		} 
		return "Y";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.BasicInfoSer#deleteEvaPeriodTypeInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int deleteEvaPeriodTypeInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.basicInfoDao.deleteEvaPeriodTypeInfo(paramMap);
	} 
	 
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * com.siping.eva.service.BasicInfoSer#getEvaPeriodTypeItemInfo(javax.servlet.http
		 * .HttpServletRequest)
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
		@Override
		public List getEvaPeriodTypeItemInfo(HttpServletRequest request) {
			List retrunList = new ArrayList();
			AdminBean admin = SessionUtil.getLoginUserFromSession(request);
			Map paramMap = ObjectBindUtil.getRequestParamData(request);
			try {
				paramMap.put("language", Messages.getLanguage(request));
				paramMap.put("AR_ADMIN_ID", admin.getAdminID());
				paramMap.put("CPNY_ID", admin.getCpnyId());
				if (paramMap.get("page") != null
						&& paramMap.get("pagesize") != null) {
					retrunList = this.basicInfoDao.getEvaPeriodTypeItemInfo(paramMap,
							NumberUtils.parseNumber(
									ObjectUtils.toString(paramMap.get("page")),
									Integer.class), NumberUtils.parseNumber(
									ObjectUtils.toString(paramMap.get("pagesize")),
									Integer.class));
				} else {
					retrunList = this.basicInfoDao.getEvaPeriodTypeItemInfo(paramMap);
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
		 * com.siping.eva.service.BasicInfoSer#getEvaPeriodTypeInfoCnt(javax.servlet
		 * .http.HttpServletRequest)
		 */
		@Override
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public int getEvaPeriodTypeItemInfoCnt(HttpServletRequest request) {
			AdminBean admin = SessionUtil.getLoginUserFromSession(request);
			Map paramMap = ObjectBindUtil.getRequestParamData(request);
			paramMap.put("language", Messages.getLanguage(request));
			paramMap.put("AR_ADMIN_ID", admin.getAdminID());
			paramMap.put("CPNY_ID", admin.getCpnyId());

			return this.basicInfoDao.getEvaPeriodTypeItemInfoCnt(paramMap);
		}
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * com.siping.eva.service.BasicInfoSer#saveAndUpdateEvaPeriodTypeItemInfo(javax.
		 * servlet.http.HttpServletRequest)
		 */
		public String saveAndUpdateEvaPeriodTypeItemInfo(HttpServletRequest request) {

			AdminBean admin = SessionUtil.getLoginUserFromSession(request);

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
				this.basicInfoDao.addEvaPeriodTypeItemInfo(insertList);
			}
			if(updateList.size()>0){
				this.basicInfoDao.updateEvaPeriodTypeItemInfo(updateList);
			} 

			return "Y";
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * com.siping.eva.service.BasicInfoSer#deleteEvaPeriodTypeItemInfo(javax.servlet
		 * .http.HttpServletRequest)
		 */
		@Override
		@SuppressWarnings({ "rawtypes" })
		public int deleteEvaPeriodTypeItemInfo(HttpServletRequest request) {
			Map paramMap = ObjectBindUtil.getRequestParamData(request);

			return this.basicInfoDao.deleteEvaPeriodTypeItemInfo(paramMap);
		} 
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * com.siping.eva.service.BasicInfoSer#getEvaTypeProcessInfo(javax.servlet.http
		 * .HttpServletRequest)
		 */
		@SuppressWarnings({ "rawtypes", "unchecked" })
		@Override
		public List getEvaTypeProcessInfo(HttpServletRequest request) {
			List retrunList = new ArrayList();
			AdminBean admin = SessionUtil.getLoginUserFromSession(request);
			Map paramMap = ObjectBindUtil.getRequestParamData(request);
			try {
				paramMap.put("language", Messages.getLanguage(request));
				paramMap.put("AR_ADMIN_ID", admin.getAdminID());
				paramMap.put("CPNY_ID", admin.getCpnyId());
				if (paramMap.get("page") != null
						&& paramMap.get("pagesize") != null) {
					retrunList = this.basicInfoDao.getEvaTypeProcessInfo(paramMap,
							NumberUtils.parseNumber(
									ObjectUtils.toString(paramMap.get("page")),
									Integer.class), NumberUtils.parseNumber(
									ObjectUtils.toString(paramMap.get("pagesize")),
									Integer.class));
				} else {
					retrunList = this.basicInfoDao.getEvaTypeProcessInfo(paramMap);
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
		 * com.siping.eva.service.BasicInfoSer#getEvaPeriodTypeInfoCnt(javax.servlet
		 * .http.HttpServletRequest)
		 */
		@Override
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public int getEvaTypeProcessInfoCnt(HttpServletRequest request) {
			AdminBean admin = SessionUtil.getLoginUserFromSession(request);
			Map paramMap = ObjectBindUtil.getRequestParamData(request);
			paramMap.put("language", Messages.getLanguage(request));
			paramMap.put("AR_ADMIN_ID", admin.getAdminID());
			paramMap.put("CPNY_ID", admin.getCpnyId());

			return this.basicInfoDao.getEvaTypeProcessInfoCnt(paramMap);
		}
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * com.siping.eva.service.BasicInfoSer#saveAndUpdateEvaTypeProcessInfo(javax.
		 * servlet.http.HttpServletRequest)
		 */
		public String saveAndUpdateEvaTypeProcessInfo(HttpServletRequest request) {

			AdminBean admin = SessionUtil.getLoginUserFromSession(request);

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
				this.basicInfoDao.addEvaTypeProcessInfo(insertList);
			}
			if(updateList.size()>0){
				this.basicInfoDao.updateEvaTypeProcessInfo(updateList);
			} 

			return "Y";
		}
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * com.siping.eva.service.BasicInfoSer#updateEvaTypeProcessOrderInfo(javax.
		 * servlet.http.HttpServletRequest)
		 */
		public String updateEvaTypeProcessOrderInfo(HttpServletRequest request) {

			AdminBean admin = SessionUtil.getLoginUserFromSession(request);

			LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
			appendMap.put("UPDATED_BY", admin.getAdminID()); 
			appendMap.put("CPNY_ID", admin.getCpnyId());

			String jsonString = request.getParameter("jsonData"); 

			List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
					.getRequestJsonData(jsonString, appendMap); 
			if(updateList.size()>0){
				this.basicInfoDao.updateEvaTypeProcessOrderInfo(updateList);
			} 

			return "Y";
		}
		
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * com.siping.eva.service.BasicInfoSer#deleteEvaTypeProcessInfo(javax.servlet
		 * .http.HttpServletRequest)
		 */
		@Override
		@SuppressWarnings({ "rawtypes" })
		public int deleteEvaTypeProcessInfo(HttpServletRequest request) {
			Map paramMap = ObjectBindUtil.getRequestParamData(request);

			return this.basicInfoDao.deleteEvaTypeProcessInfo(paramMap);
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
