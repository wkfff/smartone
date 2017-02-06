package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.EmpCalendarDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class EmpCalendarDaoImpl extends SqlMapClientSupport implements
		EmpCalendarDao {

	@SuppressWarnings("rawtypes")
	public List getEmpCalendarList(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.empCalendar.getEmpCalendarList", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	} 

	public int deleteEmpCalendarInfo(Object obj) {

		try {

			this.delete("att.empCalendar.DeleteEmpCalendarInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int getEmpCalendarInfo(Object obj) {
		int returnInt = 0;
		try {

			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.empCalendar.checkEmpCalendarInfo",
							obj)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	public int insertEmpCalendarInfo(Object obj) {

		try {

			this.insert("att.empCalendar.insertEmpCalendarInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}
}
