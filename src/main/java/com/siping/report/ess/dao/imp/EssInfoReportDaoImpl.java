package com.siping.report.ess.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List; 
 
import org.springframework.stereotype.Repository;
  
import com.siping.report.ess.dao.EssInfoReportDao; 
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class EssInfoReportDaoImpl extends SqlMapClientSupport implements
EssInfoReportDao {

	/**
	 * 保险结算
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<LinkedHashMap> getWhDataInfo(Object obj) {
		List returnList = new ArrayList();
		try {  
			returnList = this.queryForList(
					"report.ess.getWhDataInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	} 
}
