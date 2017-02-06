package com.siping.ess.service.impl;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.ess.dao.ConcludeAppDao;
import com.siping.ess.service.ConcludeAppSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class ConcludeAppSerImpl implements ConcludeAppSer{
	Logger logger = Logger.getLogger(InfoAppSerImpl.class);

	@Autowired
	private ConcludeAppDao concludeAppDao;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List getWhConclusionList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		return this.concludeAppDao.getWhConclusionList(paramMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int getWhConclusionListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		return this.concludeAppDao.getWhConclusionListCnt(paramMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public void calculateWhConclusion(HttpServletRequest request) throws SQLException {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		List<String> empList = this.concludeAppDao.getAllEmpidList(paramMap);
		List conclusionList = new ArrayList();
		for (String empid: empList){
			Map conclusionMap = new LinkedHashMap();
			double totalWh = 0.0;
			paramMap.put("EMPID", empid);
			List personHwConclusionList = this.concludeAppDao.getPersonHwConclusionList(paramMap);
			for(Object obj: personHwConclusionList){
				Map tmpMap = (Map)obj;
				Object weiNo = (Object) tmpMap.get("WEI_NO");
				if(weiNo!= null){
					double wh = ((BigDecimal) tmpMap.get("WORK_HOUR")).doubleValue();
					double weigh = ((BigDecimal) tmpMap.get("WEI_VALUE")).doubleValue();
					conclusionMap.put("WEI_"+weiNo.toString()+"_HOUR", wh);
					conclusionMap.put("WEI_"+weiNo.toString()+"_DAY", wh/8);
					totalWh = totalWh + weigh*wh;
				}
			}
			conclusionMap.put("TOTAL_WH", totalWh);
			conclusionMap.put("TOTAL_WD", totalWh/8);
			conclusionMap.put("EMPID", empid);
			conclusionMap.put("MONTH", paramMap.get("MONTH"));
			conclusionList.add(conclusionMap);
		}
		this.concludeAppDao.addWhConclusion(conclusionList);
	}

}
