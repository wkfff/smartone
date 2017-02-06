package com.siping.fico.dao;

import java.sql.SQLException;
import java.util.List;

public interface AccountDao {

	@SuppressWarnings("rawtypes")
	public List getAccountList(Object object) throws SQLException;
	
    @SuppressWarnings("rawtypes")
	public void addAccounts(List list) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void updateAccounts(List list) throws SQLException;
}
