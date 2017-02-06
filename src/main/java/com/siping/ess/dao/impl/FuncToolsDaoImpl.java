package com.siping.ess.dao.impl;

import java.sql.SQLException;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.siping.ess.dao.FuncToolsDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class FuncToolsDaoImpl extends SqlMapClientSupport implements FuncToolsDao {

	
	@SuppressWarnings("rawtypes")
	public List getDeptTree(Object object) {
		List returnMap = null ;
		try {
			returnMap = this.queryForList("ess.funcTools.getDeptTree");
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return returnMap;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAllEmpDeptTree() {
		List returnMap = null ;
		try {
			returnMap = this.queryForList("ess.funcTools.getAllEmpDeptTree");
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return returnMap;
	}

}
