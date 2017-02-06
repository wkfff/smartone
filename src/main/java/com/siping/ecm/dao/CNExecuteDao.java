package com.siping.ecm.dao;

import java.sql.SQLException;
import java.util.List;

public interface CNExecuteDao {

	@SuppressWarnings("rawtypes")
	public void approveChangeNo(List list) throws SQLException;
	public Object getChangeNoDetail(Object object);
	@SuppressWarnings("rawtypes")
	public void updateECMObject(List list) throws SQLException;
	
	public void setCNObject2Changed(Object object)throws SQLException;
	
	public void overwriteObject(Object object)throws SQLException;
}
