package com.siping.web.utility.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityProdInfoDao;

@Repository
public class UtilityProdInfoDaoImpl extends SqlMapClientSupport implements UtilityProdInfoDao {

	
	@SuppressWarnings("rawtypes")
	@Override
	public List getProductList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("utility.proInfo.getProductList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getProductListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("utility.proInfo.getProductListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getBasicProductList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("utility.proInfo.getBasicProductList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getBasicProductListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("utility.proInfo.getBasicProductListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getStorageList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("utility.proInfo.getStorageList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getStorageListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("utility.proInfo.getStorageListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
}
