package com.siping.ecm.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.ecm.dao.CNExecuteDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CNExecuteDaoImpl extends SqlMapClientSupport implements CNExecuteDao {

	@SuppressWarnings("rawtypes")
	@Override
	public void approveChangeNo(List list) throws SQLException {
		this.updateForList("ecm.cnManage.approveChangeNo", list);
	}

	@Override
	public Object getChangeNoDetail(Object object) {
		Object object2 = null;
		try {
			object2 = this.queryForObject("ecm.cnInfo.getChangeNoDetail",object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return object2;	
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updateECMObject(List list) throws SQLException {
		this.insertForList("ecm.cnManage.addObject", list);	
	}

	@Override
	public void setCNObject2Changed(Object object) throws SQLException {
		this.update("ecm.cnExecute.setCNObject2Changed", object);
		
	}

	@Override
	public void overwriteObject(Object object) throws SQLException {
		this.update("ecm.cnExecute.overwriteObject", object);
	}
	

	
}
