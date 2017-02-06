package com.siping.web.utility.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.dao.UtilityPostInfoDao;
import com.siping.web.utility.service.UtilityPostInfoSer;
@Service
public class UtilityPostInfoSerImpl implements UtilityPostInfoSer {

	Logger logger = Logger.getLogger(UtilityPostInfoSerImpl.class);

	@Autowired
	private UtilityPostInfoDao utilityPostInfoDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getPostInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.utilityPostInfoDao.getPostInfoList(
					paramMap, NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.utilityPostInfoDao
					.getPostInfoList(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getPostInfoCnt(HttpServletRequest request) {
		int retrunInt = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunInt = this.utilityPostInfoDao.getPostInfoCnt(paramMap);

		return retrunInt;
	}

}
