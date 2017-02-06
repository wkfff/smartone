package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;
import com.siping.att.dao.AttCardRecordDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttCardRecordDaoImpl extends SqlMapClientSupport implements
		AttCardRecordDao {

	@SuppressWarnings("rawtypes")
	public List getAttCardRecordInfo(Object object) {
		 
		List returnList = new ArrayList(); 
		try {
			returnList = this.queryForList(
					"att.attCardRecord.getAttCardRecordInfo", object);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@SuppressWarnings("rawtypes")
	public List getAttCardRecordInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.attCardRecord.getAttCardRecordInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	public int getAttCardRecordInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.attCardRecord.getAttCardRecordInfoCnt",
							object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	@SuppressWarnings("rawtypes")
	public int updateAttCardRecordInfo(List list) {

		try {
			this.updateForList("att.attCardRecord.updateAttCardRecordInfo",
					list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	@SuppressWarnings("rawtypes")
	public int deleteAttCardRecordInfo(List list) {

		try {
			this.deleteForList("att.attCardRecord.deleteAttCardRecordInfo",
					list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int addAttCardRecordInfo(Object object) {

		try {
			this.insert("att.attCardRecord.addAttCardRecordInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public void addAtrecordInfoList(List<LinkedHashMap> list) throws SQLException {
		/*Map in = null;
		Map out = null;
		List l = new ArrayList();
		for(Map m:list){
			in = new LinkedHashMap();
			in.put("EMPID", m.get("EMPID"));
			in.put("ATT_DATE", m.get("ATT_DATE"));
			in.put("R_TIME", m.get("ENTER_TIME"));
			in.put("CARD_DOOR_TYPE", "IN");
			in.put("CREATED_BY", m.get("CREATED_BY"));
			l.add(in);
			if(m.get("OUT_TIME")!=null&&!"".equals(m.get("OUT_TIME"))){
				out = new LinkedHashMap();
				out.put("EMPID", m.get("EMPID"));
				out.put("ATT_DATE", m.get("ATT_DATE"));
				out.put("R_TIME", m.get("OUT_TIME"));
				out.put("CARD_DOOR_TYPE", "OUT");
				out.put("CREATED_BY", m.get("CREATED_BY"));
				l.add(out);
			}
		}*/
		try {
			this.insertForList("att.attCardRecord.addAttCardRecordInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
