package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;

import com.siping.att.dao.AttDetailCalulateDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttDetailCalulateDaoImpl extends SqlMapClientSupport implements
		AttDetailCalulateDao {

	/**
	 * attendance keeper (non-Javadoc)
	 * 
	 * @see com.siping.att.dao.AttDetailCalulateDao#getAttSupervisorList(java.util.LinkedHashMap)
	 */
	@SuppressWarnings("rawtypes")
	public List getAttSupervisorList(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this
					.queryForList("att.attDetailCalulate.getAttSupervisorList");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * detail Calculate (non-Javadoc)
	 * 
	 * @see com.siping.att.dao.AttDetailCalulateDao#detailCalculate(java.util.LinkedHashMap)
	 */
	@SuppressWarnings("rawtypes")
	public String detailCalculate(LinkedHashMap paramMap) {
		String returnString = "";
		try {
			this.insert("att.attDetailCalulate.detailCalculate", paramMap);

			returnString = ObjectUtils.toString(paramMap.get("empID"));
		} catch (SQLException e) {
			returnString = e.getMessage();
			e.printStackTrace();
		}

		return returnString;
	}

}
