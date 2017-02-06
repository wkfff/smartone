package com.siping.att.service.impl;

import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.att.dao.AttMonthCalculateDao;
import com.siping.att.service.AttMonthCalculateSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttMonthCalculateSerImp implements AttMonthCalculateSer {
	Logger logger = Logger.getLogger(AttMonthCalculateSerImp.class);

	@Autowired
	private AttMonthCalculateDao attMonthCalculateDao;

	@SuppressWarnings({ "rawtypes" })
	public String monthCalculate(HttpServletRequest request) {
		String returnString = Messages.getMessage(request,
				"hrms.calculationFailure");
		if (this.validateMonthlyStatus(request)) {
			LinkedHashMap paramMap = ObjectBindUtil
					.getRequestParamData(request);
			returnString = this.attMonthCalculateDao.monthCalculate(paramMap);
		} else {
			returnString = "<font color='red'>" + Messages.getMessage(request,
					"hrms.calculationFailure.monthlyLocked") + "</font>";
		}
		return returnString;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean validateMonthlyStatus(HttpServletRequest request) {
		boolean returnFlag = false;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		paramMap.put("UPDATED_BY", admin.getAdminID());

		if (this.attMonthCalculateDao.getMonthlyStatusCnt(paramMap) > 0) {
			this.attMonthCalculateDao.updateAttStatus(paramMap);
		} else {
			this.attMonthCalculateDao.insertMonthlyStatus(paramMap);
		}
		int returnInt = this.attMonthCalculateDao.getMonthlyStatus(paramMap);
		if (returnInt == 0) {
			returnFlag = true;
		}
		return returnFlag;

	}

}
