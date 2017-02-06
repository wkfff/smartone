package com.siping.fico.dao;

import java.sql.SQLException;
import java.util.List;

public interface InvoiceDao {

	@SuppressWarnings("rawtypes")
	public List getInvoiceList(Object object) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getPositionList(Object object) throws SQLException;
	
	public Object getInvoiceDetail(Object object) throws SQLException;
	
	public String addInvoice(Object object) throws SQLException;
	
	public void updateInvoice(Object object) throws SQLException;
	
    @SuppressWarnings("rawtypes")
	public void addPositions(List list) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void updatePositions(List list) throws SQLException;
}
