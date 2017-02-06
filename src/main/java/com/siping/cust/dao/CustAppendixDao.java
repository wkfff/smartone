package com.siping.cust.dao;

import java.sql.SQLException;
import java.util.List;

public interface CustAppendixDao {
	@SuppressWarnings("rawtypes")
	public List getAppendixList(Object object);
	public int getAppendixListCnt(Object object);
	public void removeAppendix(Object object) throws SQLException;
}
