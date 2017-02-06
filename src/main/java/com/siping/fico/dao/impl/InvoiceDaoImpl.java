package com.siping.fico.dao.impl;

import java.sql.SQLException;
import java.util.List;
import org.springframework.stereotype.Repository;

import com.siping.fico.dao.InvoiceDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class InvoiceDaoImpl extends SqlMapClientSupport implements InvoiceDao {

	@SuppressWarnings("rawtypes")
	@Override
	public List getInvoiceList(Object object) throws SQLException {
		return this.queryForList("fico.invoice.getInvoiceList", object);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getPositionList(Object object) throws SQLException {
		return this.queryForList("fico.invoice.getPositionList", object);
	}

	@Override
	public Object getInvoiceDetail(Object object) throws SQLException {
		return this.queryForObject("fico.invoice.getInvoiceDetail", object);
	}

	@Override
	public String addInvoice(Object object) throws SQLException {		
		return this.insert("fico.invoice.addInvoice", object).toString();
	}

	@Override
	public void updateInvoice(Object object) throws SQLException {
		this.update("fico.invoice.updateInvoice", object);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void addPositions(List list) throws SQLException {
		this.insertForList("fico.invoice.addPosition", list);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updatePositions(List list) throws SQLException {
		this.updateForList("fico.invoice.updatePosition", list);
	}

}
