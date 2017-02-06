package com.siping.pa.dao.imp.salary;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;

import com.siping.pa.dao.salary.PaResultDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaResultDaoImpl extends SqlMapClientSupport implements PaResultDao {
	
	/**
	 * 工资结算
	 * @param List
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String paBalance(LinkedHashMap paramMap) {
		String returnString = "" ;
		
		try {
			paramMap.put("message", "") ;
			this.insert("pa.paResult.paBalance", paramMap) ;
			
			returnString = ObjectUtils.toString(paramMap.get("message")) ;
		} catch (SQLException e) {	
			returnString = e.getMessage() ;
			
			e.printStackTrace();
		}
		
		return returnString ;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getPaColumns(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.paResult.getPaColumns",object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnList;
	}
}
