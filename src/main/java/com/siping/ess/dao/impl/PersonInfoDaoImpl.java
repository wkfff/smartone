package com.siping.ess.dao.impl;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.ess.dao.PersonInfoDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PersonInfoDaoImpl extends SqlMapClientSupport implements
		PersonInfoDao {
 
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getEducationInfoList(Object object, int currentPage,
			int pageSize) {
		Map object2 = new LinkedHashMap();
		try {
			List Rows=this.queryForList("ess.personinfo.retrieveContractInfo", object, currentPage, pageSize);
			Integer count=(Integer) this.queryForObject("ess.personinfo.retrieveContractInfoCnt", object);
			object2.put("Rows", Rows);
			object2.put("Total", count);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return object2;	
	}

	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getEvaluateforList(Object object, int currentPage, int pageSize) {
		Map object2 = new LinkedHashMap();
		try {
			List Rows=this.queryForList("ess.personinfo.retrieveEvaluateByYear", object, currentPage, pageSize);
			Integer count=(Integer) this.queryForObject("ess.personinfo.retrieveEvaluateByYearCnt", object);
			object2.put("Rows", Rows);
			object2.put("Total", count);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return object2;	
	}

}
