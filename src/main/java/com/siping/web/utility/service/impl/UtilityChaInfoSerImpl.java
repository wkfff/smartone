package com.siping.web.utility.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.service.UtilityChaInfoSer;
import com.siping.web.utility.dao.*;

@Service
public class UtilityChaInfoSerImpl implements UtilityChaInfoSer {

	Logger logger = Logger.getLogger(UtilityChaInfoSer.class);
	@Autowired
	private UtilityChaInfoDao utilityChaInfoDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getChannelList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.utilityChaInfoDao.getChannelList(paramMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int getChannelListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);		
		return this.utilityChaInfoDao.getChannelListCnt(paramMap);
	}
}
