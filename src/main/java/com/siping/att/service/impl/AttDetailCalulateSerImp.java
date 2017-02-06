package com.siping.att.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.att.dao.AttDaliyLockDao;
import com.siping.att.dao.AttDetailCalulateDao; 
import com.siping.att.service.AttDetailCalulateSer;
import com.siping.web.utility.ObjectBindUtil;

@Service
public class AttDetailCalulateSerImp implements AttDetailCalulateSer {
	Logger logger = Logger.getLogger(AttDetailCalulateSerImp.class);

	@Autowired
	private AttDetailCalulateDao attDetailCalulateDao; 
	@Autowired
	private AttDaliyLockDao attDaliyLockDao;

	/**
	 * attendance keeper (non-Javadoc)
	 * 
	 * @see com.siping.att.service.AttDetailCalulateSer#getAttSupervisorList(javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings("rawtypes")
	public List getAttSupervisorList(HttpServletRequest request) {
		return this.attDetailCalulateDao.getAttSupervisorList(request);
	}

	/**
	 * detail Calculate (non-Javadoc)
	 * 
	 * @see com.siping.att.service.AttDetailCalulateSer#detailCalculate(javax.servlet.http.HttpServletRequest)
	 */
	@SuppressWarnings("rawtypes")
	public String detailCalculate(HttpServletRequest request) {
		String returnString = "";
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		this.attDaliyLockDao.addDailyLock(paramMap);
		returnString = this.attDetailCalulateDao.detailCalculate(paramMap);

		return returnString;
	}
}
