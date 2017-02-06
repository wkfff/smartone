package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.cust.dao.SalesSettingDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SalesSettingDaoImpl extends SqlMapClientSupport implements SalesSettingDao{
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getSalesKeeperList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("sales.salesSetting.getSalesKeeperList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getSalesKeeperDeptInfo(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("sales.salesSetting.getSalesKeeperDeptInfo",object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int getSalesKeeperListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("sales.salesSetting.getSalesKeeperListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}

	@Override
	public int getRecordCount(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("sales.salesSetting.getRecordCount",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@Override
	public Object getSalesKeeperDetail(Object object) {
		Object object2 = null;
		try {
			object2 = this.queryForObject("sales.salesSetting.getSalesKeeperDetail",object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return object2;	
	}
	
	@Override
	public void removeSalesKeeper(Object object) throws SQLException{
		try {
			this.update("sales.salesSetting.removeSalesKeeper",object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}	
	}
	
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public void addSalesKeeperInfo(List list) throws SQLException {
		try{
			this.updateForList("sales.salesSetting.addSalesKeeperInfo", list);
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
	}

	@Override
	public void addSalesKeeper(Object object) throws SQLException {
		
		try {
			this.insert("sales.salesSetting.addSalesKeeper",object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
	}

	@Override
	public void updateSalesKeeper(Object object) throws SQLException {
		
		try {
			this.update("sales.salesSetting.updateSalesKeeper",object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
	}

	@Override
	public void removeSalesKeeperInfo(Object object) throws SQLException {
		
		try {
			this.delete("sales.salesSetting.removeSalesKeeperInfo",object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}	
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getDirectSalesList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("sales.salesSetting.getDirectSalesList",object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getNetworkSalesList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("sales.salesSetting.getNetworkSalesList",object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getDirectSalesListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("sales.salesSetting.getDirectSalesListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}

	@Override
	public int getNetworkSalesListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("sales.salesSetting.getNetworkSalesListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void addDirectSales(List object) throws SQLException {
		this.updateForList("sales.salesSetting.addDirectSales", object);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updateDirectSales(List object) throws SQLException {
		this.updateForList("sales.salesSetting.updateDirectSales", object);
	}

	@Override
	public void removeDirectSales(Object object) throws SQLException {
		this.update("sales.salesSetting.removeDirectSales", object);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void addNetworkSales(List object) throws SQLException {
		this.updateForList("sales.salesSetting.addNetworkSales", object);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updateNetworkSales(List object) throws SQLException {
		this.updateForList("sales.salesSetting.updateNetworkSales", object);
	}
}
