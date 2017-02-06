package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.att.dao.AttProgressDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttProgressDaoImpl extends SqlMapClientSupport implements AttProgressDao {
	
	@SuppressWarnings("rawtypes")
	public List getAttProgressInfo(Object obj) {
		List returnList = new ArrayList() ;
		try { 
			returnList = this.queryForList("att.attProgress.getAttProgressInfo",obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	public int updateAttProgressInfo(Object obj) {
		try {
			
			this.update("att.attProgress.updateAttProgressInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
		return 0 ;
	}
}
