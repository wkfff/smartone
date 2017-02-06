package com.siping.att.service.impl;

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

import com.siping.att.dao.AttDaliyLockDao;
import com.siping.att.dao.AttDetailDao;
import com.siping.att.service.AttDetailSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.dao.UtilityOtherInfoDao;

@Service
public class AttDetailSerImp implements AttDetailSer {
	Logger logger = Logger.getLogger(AttDetailSerImp.class);

	@Autowired
	private AttDetailDao attDetailDao;
	@Autowired
	private AttDaliyLockDao attDaliyLockDao;

	@Autowired
	private UtilityOtherInfoDao utilityOtherInfoDao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getAttDetailList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// session用户信息
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = attDetailDao.getAttDetailList(paramMap, NumberUtils
					.parseNumber(ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.attDetailDao.getAttDetailList(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getAttDetailListCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());

		return this.attDetailDao.getAttDetailListCnt(paramMap);
	};

	/**
	 * 获取考勤月开始日期信息
	 * 
	 * @param request
	 * @return
	 */
	public String getStartDateStr(HttpServletRequest request) {
		return getStartDateStr(request,"yyyy/MM/dd");
	}

	/**
	 * 获取考勤月结束日期信息
	 * 
	 * @param request
	 * @return
	 */
	public String getEndDateStr(HttpServletRequest request) {
		return getEndDateStr(request,"yyyy/MM/dd");
	}
	
	/**
	 * 获取考勤月开始日期信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String getStartDateStr(HttpServletRequest request,String format) {
		String sDate = DateUtil.getSysdateString(format);
		LinkedHashMap paramMap = new LinkedHashMap();
		paramMap.put("strDate", sDate);
		paramMap.put("timeFormat", format);
		sDate = this.utilityOtherInfoDao.getStartDateStr(paramMap);
		return sDate;
	}

	/**
	 * 获取考勤月结束日期信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String getEndDateStr(HttpServletRequest request,String format) {
		String eDate = DateUtil.getSysdateString(format);
		LinkedHashMap paramMap = new LinkedHashMap();
		paramMap.put("strDate", eDate);
		paramMap.put("timeFormat", format);
		eDate = this.utilityOtherInfoDao.getEndDateStr(paramMap);
		return eDate;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String updateAttDetailInfo(HttpServletRequest request) {
		String result = "";
		// 页面参数
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> arDetailInfoList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		for (int i = 0; i < arDetailInfoList.size(); i++) {
			LinkedHashMap arDetailInfoMap = (LinkedHashMap) arDetailInfoList
					.get(i);
			arDetailInfoMap.put("language", Messages.getLanguage(request));
			LinkedHashMap map = (LinkedHashMap) attDetailDao
					.validateDetailItemType(arDetailInfoMap);
			if (map.get("DATE_TYPE").toString()
					.indexOf(arDetailInfoMap.get("DATE_TYPE").toString()) == -1
					|| !map.get("UNIT")
							.toString()
							.equals(arDetailInfoMap.get("UNIT_CODE").toString())) {
				result = Messages.getMessage(request, "hrms.attendanceItem")
						+ "[" + map.get("ITEM_NAME").toString() + "]"
						+ Messages.getMessage(request, "and") + "["
						+ arDetailInfoMap.get("AR_DATE_STR").toString() + "]"
						+ Messages.getMessage(request, "hrms.dateType")
						+ Messages.getMessage(request, "hrms.notSame");
				break;
			}
		}
		if (result.equals("")) {
			this.attDetailDao.updateAttDetailInfo(arDetailInfoList);
			result = "Y";
		}

		return result;
	}

	public String deleteAttDetailInfo(HttpServletRequest request) {

		String result = "";
		// 页面参数
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> arDetailInfoList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		this.attDetailDao.deleteAttDetailInfo(arDetailInfoList);
		result = "Y";
		return result;
	}
	  
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String addAttDetailInfo(HttpServletRequest request) {
		String result = "";
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面参数
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		// 页面参数

		int returnInt = this.attDaliyLockDao.validateDailyLock(paramMap);
		if (returnInt == 1) {
			result = "考勤日[" + paramMap.get("AR_DATE_STR").toString()
					+ "]已经锁定,不能进行明细维护.";
		} else {
			this.attDetailDao.addAttDetailInfo(paramMap);
			result = "Y";
		}
		return result;
	}
}
