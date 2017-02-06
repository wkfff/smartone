package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttendanceKeeperDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttendanceKeeperDaoImpl extends SqlMapClientSupport implements
		AttendanceKeeperDao {

	/**
	 * 取得考勤员信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getAttendanceKeeper(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();

		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.attendanceKeeper.getAttendanceKeeperInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnObj;
	}

	/**
	 * 取得所有考勤员列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAttendanceKeeperInfo(Object obj) {
		List returnList = new ArrayList();

		try {
			returnList = this.queryForList(
					"att.attendanceKeeper.getAttendanceKeeperInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取得所有考勤员信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAttendanceKeeperInfo(Object obj, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.attendanceKeeper.getAttendanceKeeperInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 插入考勤员信息
	 * 
	 * @param Object
	 * @return
	 */
	public int addAttendanceKeeperInfo(Object obj) {

		try {

			this.insert("att.attendanceKeeper.addAttendanceKeeperInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 更新考勤员信息
	 * 
	 * @param Object
	 * @return
	 */
	public int updateAttendanceKeeperInfo(Object obj) {

		try {

			this.update("att.attendanceKeeper.updateAttendanceKeeperInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 删除考勤员信息
	 * 
	 * @param Object
	 * @return
	 */
	public int deleteAttendanceKeeperInfo(Object obj) {

		try {
			this.startTransaction();

			this.delete("att.attendanceKeeper.deleteAttendanceKeeperDeptInfo",
					obj);

			this.delete("att.attendanceKeeper.deleteAttendanceKeeperInfo", obj);

			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				this.endTransation();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return 0;
	}

	// @Override
	public int getAttendanceKeeperInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject(
							"att.attendanceKeeper.getAttendanceKeeperInfoCnt",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 取得考勤员的部门信息
	 * 
	 * @param Object
	 * @return
	 */
	// @Override
	@SuppressWarnings("rawtypes")
	public List getAttendanceKeeperDeptInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.attendanceKeeper.getAttendanceKeeperDeptInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 插入考勤员的部门信息
	 * 
	 * @param Object
	 * @return
	 */
	// @Override
	@SuppressWarnings("rawtypes")
	public int addAttendanceKeeperDeptInfo(List list) {

		try {
			this.startTransaction();

			this.delete("att.attendanceKeeper.deleteAttendanceKeeperDeptInfo",
					list.get(0));

			this.insertForList(
					"att.attendanceKeeper.addAttendanceKeeperDeptInfo", list);

			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				this.endTransation();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return 0;
	}
}
