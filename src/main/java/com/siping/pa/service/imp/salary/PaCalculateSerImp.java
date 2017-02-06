package com.siping.pa.service.imp.salary;

import java.sql.SQLException;
import java.util.LinkedHashMap; 
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.pa.dao.salary.PaCalculateDao;
import com.siping.pa.dao.salary.PaResultDao;
import com.siping.pa.service.salary.PaCalculateSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PaCalculateSerImp implements PaCalculateSer {

	Logger logger = Logger.getLogger(PaCalculateSerImp.class);
	
	@Autowired
	private PaCalculateDao paCalculateDao ;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String paCalculate(HttpServletRequest request) {
		String returnString = "" ;
				
		// 页面提交数据
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CPNY_ID", admin.getCpnyId());

		returnString = paCalculateDao.paCalculate(paramMap) ;
		
		return returnString ;
	}


	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getPaMonInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return paCalculateDao.getPaMonInfo(paramMap) ;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getPaMonInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return paCalculateDao.getPaMonInfoCnt(paramMap) ;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String updatePaMonthInfo(HttpServletRequest request) {
		String resultString = "Y";
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		// 页面参数
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> infoList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		try{
			List paramList = this.paCalculateDao.getPaSqlColumns(paramMap);
			for (int j = 0; j < infoList.size(); j++) {
				LinkedHashMap paraMap = (LinkedHashMap) infoList.get(j);
				String sqlparamString = "UPDATE PA_HISTORY SET ";
				for (int i = 0; i < paramList.size(); i++) {
					LinkedHashMap map = (LinkedHashMap) paramList.get(i);
					sqlparamString += map.get("COLUMN_NAME") + "="
							+ paraMap.get(map.get("COLUMN_NAME"));
					if (i != paramList.size() - 1) {
						sqlparamString += ",";
					}
				}
				sqlparamString += " WHERE PA_MONTH ='" + paramMap.get("PA_MONTH").toString() + "' AND  EMPID= "
						+ "'" + paraMap.get("EMPID") + "'";
				System.out.println(sqlparamString);
				paraMap.put("sql", sqlparamString);
				this.paCalculateDao.updatePaMonthInfo(paraMap);
			}
		}catch(SQLException e){
			resultString = e.getMessage();
			e.printStackTrace();
		}
		return resultString;
		
	}

}
