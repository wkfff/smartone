package com.siping.web.utility.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityDocInfoDao;

@Repository
public class UtilityDocInfoDaoImpl extends SqlMapClientSupport implements UtilityDocInfoDao{

	@Override
	public int getDocListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("utility.docInfo.getDocListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getDocList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("utility.docInfo.getDocList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	
	@Override
	public int getDocTypeListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("utility.docInfo.getDocTypeListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getDocTypeList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("utility.docInfo.getDocTypeList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}
	
	
}
