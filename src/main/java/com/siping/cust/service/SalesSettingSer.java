package com.siping.cust.service;

import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

public interface SalesSettingSer {
	@SuppressWarnings({ "rawtypes" })
	public List getSalesKeeperList(HttpServletRequest request);
	
	public int getSalesKeeperListCnt(HttpServletRequest request);
	
    @SuppressWarnings("rawtypes")
	public List getDirectSalesList(HttpServletRequest request);
	
	public int getDirectSalesListCnt(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getNetworkSalesList(HttpServletRequest request);
	
	public int getNetworkSalesListCnt(HttpServletRequest request);
	
	public Object getSalesKeeperDetail(HttpServletRequest request);
	
	public String removeSalesKeeper(HttpServletRequest request);
	
	public void transferSalesKeeper(HttpServletRequest request) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getSalesKeeperDeptInfo(HttpServletRequest request);
	
	public boolean isSupervisor(HttpServletRequest request);
	
	public void transferDirectSales(HttpServletRequest request) throws SQLException;
	public void transferNetworkSales(HttpServletRequest request) throws SQLException;
	public String removeDirectSales(HttpServletRequest request) throws SQLException;
}
