package com.siping.eva.service.imp;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;
 
import com.siping.eva.dao.KPIDao;
import com.siping.eva.service.KPISer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class KPISerImpl implements KPISer {

	Logger logger = Logger.getLogger(KPISerImpl.class);

	@Autowired
	private KPIDao kpiDao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#getEvaKPIInfo(javax.servlet.http
	 * .HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getEvaKPIInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		try {
			paramMap.put("language", Messages.getLanguage(request));
			paramMap.put("HR_ADMIN_ID", admin.getAdminID());
			paramMap.put("CPNY_ID", admin.getCpnyId());
			if (paramMap.get("page") != null
					&& paramMap.get("pagesize") != null) {
				retrunList = this.kpiDao.getEvaKPIInfo(paramMap,
						NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("pagesize")),
								Integer.class));
			} else {
				retrunList = this.kpiDao.getEvaKPIInfo(paramMap);
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
	 * com.siping.eva.service.KPISer#getEvaKPIInfoCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getEvaKPIInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.kpiDao.getEvaKPIInfoCnt(paramMap);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#saveAndUpdateEvaKPIInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String saveAndUpdateEvaKPIInfo(HttpServletRequest request) {

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
			this.kpiDao.addEvaEmpWorkInfo(insertList);
			paramMap.remove("jsonData");
			if(this.kpiDao.checkEvaEmpEveInfo(paramMap) == 0){
				this.kpiDao.addEvaEmpEveInfo(paramMap);
			}
		}
		if(updateList.size()>0){
			this.kpiDao.updateEvaEmpWorkInfo(updateList);
		} 
		return "Y";
	}


	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#updateEvaKPIScore(javax.
	 * servlet.http.HttpServletRequest)
	 */
	public String updateEvaKPIScore(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,"update", appendMap);
		if(updateList.size()>0){
			this.kpiDao.updateEvaKPIScore(updateList);
		} 
		return "Y";
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#updateEssEmpOngoingWorkInfo(javax.
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
			this.kpiDao.updateEssEmpOngoingWorkInfo(updateList);
		} 
		paramMap.remove("jsonData");
		this.kpiDao.updateEssWorkFlagInfo(paramMap);
		return "Y";
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#deleteEvaKPIInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int deleteEvaKPIInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.kpiDao.deleteEvaKPIInfo(paramMap);
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#getKPIScoreListByKPI(javax.servlet.http
	 * .HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getKPIScoreListByKPI(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		try {
			paramMap.put("language", Messages.getLanguage(request));
			paramMap.put("HR_ADMIN_ID", admin.getAdminID());
			paramMap.put("CPNY_ID", admin.getCpnyId());
			if (paramMap.get("page") != null
					&& paramMap.get("pagesize") != null) {
				retrunList = this.kpiDao.getKPIScoreListByKPI(paramMap,
						NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("pagesize")),
								Integer.class));
			} else {
				retrunList = this.kpiDao.getKPIScoreListByKPI(paramMap);
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
	 * com.siping.eva.service.KPISer#getKPIScoreListByKPICnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getKPIScoreListByKPICnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.kpiDao.getKPIScoreListByKPICnt(paramMap);
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#getKPIScoreListByEmployee(javax.servlet.http
	 * .HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getKPIScoreListByEmployee(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		try {
			paramMap.put("language", Messages.getLanguage(request));
			paramMap.put("HR_ADMIN_ID", admin.getAdminID());
			paramMap.put("CPNY_ID", admin.getCpnyId());
			if (paramMap.get("page") != null
					&& paramMap.get("pagesize") != null) {
				retrunList = this.kpiDao.getKPIScoreListByKPI(paramMap,
						NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
								ObjectUtils.toString(paramMap.get("pagesize")),
								Integer.class));
			} else {
				retrunList = this.kpiDao.getKPIScoreListByKPI(paramMap);
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
	 * com.siping.eva.service.KPISer#getKPIScoreListByEmployeeCnt(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getKPIScoreListByEmployeeCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		return this.kpiDao.getKPIScoreListByEmployeeCnt(paramMap);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#getKPIScoreDetail(javax.servlet.http
	 * .HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Object getKPIScoreDetail(HttpServletRequest request) {
		Object returnMap = null;
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		try { 
			paramMap.put("language", Messages.getLanguage(request)); 
			returnMap = this.kpiDao.getKPIScoreDetail(paramMap);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#saveAndupdateEvaKPIInfo(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String saveAndupdateEvaKPIInfo(HttpServletRequest request) {

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
			this.kpiDao.addEvaKPIInfo(insertList);
		}
		if(updateList.size()>0){
			this.kpiDao.updateEvaKPIInfo(updateList);
		} 
		return "Y";
	}  
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#addEvaKPIScore(javax.
	 * servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String addEvaKPIScore(HttpServletRequest request) {

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
			this.kpiDao.addEvaKPIScore(updateList);
		} 
		paramMap.remove("jsonData"); 
		this.kpiDao.updateEvaItemFlagInfo(paramMap);
		return "Y";
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#updateEssEmpOngoingItemInfo(javax.
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
			this.kpiDao.updateEssEmpOngoingItemInfo(updateList);
		} 
		paramMap.remove("jsonData");
		this.kpiDao.updateEssItemFlagInfo(paramMap);
		return "Y";
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.eva.service.KPISer#deleteEvaEmpItemInfo(javax.servlet
	 * .http.HttpServletRequest)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int deleteEvaEmpItemInfo(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.kpiDao.deleteEvaEmpItemInfo(paramMap);
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

	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getEvaKpiTypeInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = kpiDao.getEvaKpiTypeInfo(paramMap,
				NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = kpiDao.getEvaKpiTypeInfo(paramMap);
		}
		return retrunList;
	}
	@SuppressWarnings({ "rawtypes" })
	@Override
	public int getEvaKpiTypeInfoCnt(HttpServletRequest request) {
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);
		return kpiDao.getEvaKpiTypeInfoCnt(paramMap);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private LinkedHashMap setGetPaInputItemParam(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		
		return paramMap;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getEvaKpiItemInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			
			if (paramMap.get("userFlag")!=null) {
				retrunList = kpiDao.getEvaKpiItemInfoUnused(paramMap, NumberUtils
						.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
						ObjectUtils.toString(paramMap.get("pagesize")),
						Integer.class));
			}else if(paramMap.get("userFlag2")!=null){
				retrunList = kpiDao.getEvaKpiItemInfoUnusedManager(paramMap, NumberUtils
						.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
						ObjectUtils.toString(paramMap.get("pagesize")),
						Integer.class));
			}else{
				retrunList = kpiDao.getEvaKpiItemInfo(paramMap, NumberUtils
						.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
						ObjectUtils.toString(paramMap.get("pagesize")),
						Integer.class));
			}
		} else {
			if (paramMap.get("userFlag")!=null) {
				retrunList = kpiDao.getEvaKpiItemInfoUnused(paramMap);
			}else if(paramMap.get("userFlag2")!=null){
				retrunList = kpiDao.getEvaKpiItemInfoUnusedManager(paramMap);
			}else{
				retrunList = kpiDao.getEvaKpiItemInfo(paramMap);
			}
		}
		return retrunList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int getEvaKpiItemInfoCnt(HttpServletRequest request) {
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);
		if (paramMap.get("userFlag")!=null) {
			return kpiDao.getEvaKpiItemInfoCntUnused(paramMap);
		}else if(paramMap.get("userFlag2")!=null){
			return kpiDao.getEvaKpiItemInfoCntUnusedManager(paramMap);
		}else{
			return kpiDao.getEvaKpiItemInfoCnt(paramMap);
		}
	}

	@Override
	public void addKpiTypeInfo(HttpServletRequest request) throws SQLException {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap);
		this.kpiDao.addKpiTypeInfo(insertList);
	}

	@Override
	public void updateKpiTypeInfo(HttpServletRequest request)
			throws SQLException {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);

		this.kpiDao.updateKpiTypeInfo(updateList);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int checkDeleteKpiTypeInfo(HttpServletRequest request) {
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.kpiDao.checkDeleteKpiTypeInfo(paramMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public String deleteKpiTypeInfo(HttpServletRequest request) {
		String resultString = "Y";
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		try {
			resultString = this.kpiDao.deleteKpiTypeInfo(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}

		return resultString;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int addKpiItemInfo(HttpServletRequest request) {
		int returnInt = 1;
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());


		returnInt = this.kpiDao.addKpiItemInfo(paramMap);

		return returnInt;
	}

	@Override
	public String deleteKpiItemInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);

		return this.kpiDao.deleteKpiItemInfo(delList);
	}

	@Override
	public String updateKpiItemInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());  
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);

		return this.kpiDao.updateKpiItemInfo(updateList);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getKpiItemByMonth(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			if (paramMap.get("IS_SCORE") == null) {
				retrunList = kpiDao.getKpiItemByMonth(paramMap, NumberUtils
						.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
						ObjectUtils.toString(paramMap.get("pagesize")),
						Integer.class));
			} else {
				retrunList = kpiDao.getKpiItemByMonthIsScore(paramMap, NumberUtils
						.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
						ObjectUtils.toString(paramMap.get("pagesize")),
						Integer.class));
			}
		} else {
			if (paramMap.get("IS_SCORE") == null) {
				retrunList = kpiDao.getKpiItemByMonth(paramMap);
			} else {
				retrunList = kpiDao.getKpiItemByMonthIsScore(paramMap);
			}
		}
		return retrunList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int getKpiItemByMonthCnt(HttpServletRequest request) {
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);
		if (paramMap.get("IS_SCORE") == null) {
			return kpiDao.getKpiItemByMonthCnt(paramMap);
		} else {
			return kpiDao.getKpiItemByMonthCntIsScore(paramMap);
		}
	}

	@Override
	public String addKpiBevalidaterInfo(HttpServletRequest request) {
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);

		return this.kpiDao.addKpiBevalidaterInfo(updateList);

	}

	@Override
	public String deleteDistriKpiItemInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);

		return this.kpiDao.deleteDistriKpiItemInfo(delList);
	}

	@Override
	public int checkKpiItemDis(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);
		int returnCnt = 0;
		for (Object object : delList) {
			returnCnt += kpiDao.checkKpiItemDis(object);
		}
		return returnCnt;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getKpiItemManager(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
				retrunList = kpiDao.getKpiItemManager(paramMap, NumberUtils
						.parseNumber(
								ObjectUtils.toString(paramMap.get("page")),
								Integer.class), NumberUtils.parseNumber(
						ObjectUtils.toString(paramMap.get("pagesize")),
						Integer.class));

		} else {
				retrunList = kpiDao.getKpiItemManager(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int getKpiItemManagerCnt(HttpServletRequest request) {
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);
		return kpiDao.getKpiItemManagerCnt(paramMap);
	}

	@Override
	public void addKpiManagerInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
		this.kpiDao.addKpiManagerInfo(insertList);
	}

	@Override
	public String deleteKpiManagerInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);

		return this.kpiDao.deleteKpiManagerInfo(delList);
	}

	@Override
	public String addKpiScoreInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);

		return this.kpiDao.addKpiScoreInfo(delList);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public void getScoreByExcel(HttpServletRequest request,
			HttpServletResponse response) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 附加信息
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request)); 
		// 页面提交的JSON信息
		/*String jsonCodeString = attMonthReportDao.getAttMonthColumnInfo(paramMap); 
		List<String> codeList = new ArrayList<String>();
		if (jsonCodeString != null) {
			codeList = StringUtil.hashToList(StringUtil
					.stringToHash(jsonCodeString));
		}*/
		/*paramMap.put("codeList", codeList);*/
		/*List<String> titleList = this.attMonthReportDao
				.getAttMonthTitleInfo(paramMap);*/
		List<String> codeList = new ArrayList<String>();
		codeList.add("EMPID");
		codeList.add("CHINESENAME");
		codeList.add("SCORE");
		
		List<String> titleList = new ArrayList<String>();
		titleList.add("工号");
		titleList.add("姓名");
		titleList.add("绩效总分");
		// 1.创建一个 workbook
		HSSFWorkbook workbook = new HSSFWorkbook();

		// 2.创建一个 worksheet
		HSSFSheet worksheet = workbook.createSheet(paramMap.get("PA_MONTH").toString());

		// 3.定义起始行和列
		int startRowIndex = 0;
		int startColIndex = titleList.size();

		// 4.创建title,data,headers 
		Layouter.buildKpiScoreReport(worksheet, startRowIndex, startColIndex, titleList);

		// 5.填充数据
		FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex,
				this.kpiDao.getDataScoreByExcel(paramMap), codeList);

		// 6.设置reponse参数
		// 进行转码，使其支持中文文件名
		String fileName = null;
		try {
			fileName = java.net.URLEncoder.encode(paramMap.get("PA_MONTH").toString()+"月绩效考核总分信息", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "inline; filename="
				+ fileName + ".xls");
		// 确保发送的当前文本格式
		response.setContentType("application/vnd.ms-excel");

		// 7. 输出流
		Writer.write(response, worksheet);
	}
}
