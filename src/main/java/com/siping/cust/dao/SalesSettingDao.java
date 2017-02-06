package com.siping.cust.dao;

import java.sql.SQLException;
import java.util.List;

public interface SalesSettingDao {
	public void addSalesKeeper(Object obj) throws SQLException;
	public void updateSalesKeeper(Object obj) throws SQLException;
	@SuppressWarnings("rawtypes")
	public void addSalesKeeperInfo(List list) throws SQLException;
	@SuppressWarnings({ "rawtypes" })
	public List getSalesKeeperList(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getSalesKeeperDeptInfo(Object object);
	public int getSalesKeeperListCnt(Object object);
	public int getRecordCount(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getDirectSalesList(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getNetworkSalesList(Object object);
	public int getDirectSalesListCnt(Object object);
	public int getNetworkSalesListCnt(Object object);
	public Object getSalesKeeperDetail(Object object);
	public void removeSalesKeeper(Object object) throws SQLException;
	public void removeSalesKeeperInfo(Object object) throws SQLException;
	@SuppressWarnings("rawtypes")
	void addDirectSales(List obj) throws SQLException;
	void removeDirectSales(Object obj) throws SQLException;
	@SuppressWarnings("rawtypes")
	void updateDirectSales(List obj) throws SQLException;
	@SuppressWarnings("rawtypes")
	void addNetworkSales(List obj) throws SQLException;
	@SuppressWarnings("rawtypes")
	void updateNetworkSales(List obj) throws SQLException;
}
