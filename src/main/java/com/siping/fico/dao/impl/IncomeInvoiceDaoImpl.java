package com.siping.fico.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.fico.dao.IncomeInvoiceDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class IncomeInvoiceDaoImpl extends SqlMapClientSupport implements IncomeInvoiceDao {

	@SuppressWarnings("rawtypes")
	@Override
	public List getInvoiceList(Object object) throws SQLException {
		return this.queryForList("fico.incomeInvoice.getInvoiceList", object);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getPositionList(Object object) throws SQLException {
		return this.queryForList("fico.incomeInvoice.getPositionList", object);
	}

	@Override
	public Object getInvoiceDetail(Object object) throws SQLException {
		return this.queryForObject("fico.incomeInvoice.getInvoiceDetail", object);
	}

	@Override
	public String addInvoice(Object object) throws SQLException {
		return this.insert("fico.incomeInvoice.addInvoice", object).toString();

	}

	@Override
	public void updateInvoice(Object object) throws SQLException {
		this.update("fico.incomeInvoice.updateInvoice", object);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void addPositions(List list) throws SQLException {
		this.insertForList("fico.incomeInvoice.addPosition", list);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updatePositions(List list) throws SQLException {
		this.updateForList("fico.incomeInvoice.updatePosition", list);
	}

}
