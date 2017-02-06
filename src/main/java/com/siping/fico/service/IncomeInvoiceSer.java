package com.siping.fico.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface IncomeInvoiceSer {

	@SuppressWarnings({ "rawtypes" })
	public List getInvoiceList(HttpServletRequest request);	
	
	@SuppressWarnings({ "rawtypes" })
	public List getPositionList(HttpServletRequest request);
	
	public Object getInvoiceDetail(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public Map transferInvoice(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public Map transferPositions(HttpServletRequest request);

}
