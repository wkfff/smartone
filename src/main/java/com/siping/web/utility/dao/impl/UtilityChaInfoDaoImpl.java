package com.siping.web.utility.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityChaInfoDao;

@Repository
public class UtilityChaInfoDaoImpl extends SqlMapClientSupport implements UtilityChaInfoDao {

	
	@SuppressWarnings("rawtypes")
	@Override
	public List getChannelList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("utility.chaInfo.getChannelList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getChannelListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("utility.chaInfo.getChannelListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
}
