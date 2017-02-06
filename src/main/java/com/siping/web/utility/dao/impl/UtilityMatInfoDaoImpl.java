package com.siping.web.utility.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityMatInfoDao;

@Repository
public class UtilityMatInfoDaoImpl extends SqlMapClientSupport implements UtilityMatInfoDao {

	
	@SuppressWarnings("rawtypes")
	@Override
	public List getMaterialList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("utility.matInfo.getMaterialList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getMaterialListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("utility.matInfo.getMaterialListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
}
