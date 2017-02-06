package com.siping.web.dao;

import java.sql.SQLException;
import java.util.List;


public interface FileDownloadDao {
	public String[] getOptions(Object object ) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getTitles(Object obj) throws SQLException;
	
	public Object getProductAppendixInfo(Object obj)throws SQLException;
	public Object getCustAppendixInfo(Object obj)throws SQLException;

}
