package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.cust.dao.CustAppendixDao;
import com.siping.web.utility.SqlMapClientSupport;
@Repository
public class CustAppendixDaoImpl extends SqlMapClientSupport implements CustAppendixDao{

	@SuppressWarnings({ "rawtypes" })
	public List getAppendixList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("cust.custAppendix.getAppendixList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}
	public int getAppendixListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("cust.custAppendix.getAppendixListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}

	@Override
	public void removeAppendix(Object object) throws SQLException {
		this.update("cust.custAppendix.removeAppendix", object);
	}

}
