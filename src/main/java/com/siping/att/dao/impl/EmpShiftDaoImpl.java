package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.EmpShiftDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class EmpShiftDaoImpl extends SqlMapClientSupport implements EmpShiftDao {

	@SuppressWarnings("rawtypes")
	public List getShift010() {
		
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("att.empShift.getShift010");
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	public int addEmpShift(Object obj) { 
		try {
			
			this.insert("att.empShift.CalladdEmpShift", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	public int addShiftedInfo(Object obj) { 
		try {
			
			this.insert("att.empShift.addShiftedInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	public int deleteShiftedInfo(Object obj) { 
		try {
			
			this.delete("att.empShift.deleteShiftedInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	public int upShiftedInfo(Object obj) { 
		try {
			
			this.update("att.empShift.upShiftedInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	public int downShiftedInfo(Object obj) { 
		try {
			
			this.update("att.empShift.downShiftedInfo", obj) ; 
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	
	/**
	 * 已经排班人员信息
	 * 
	 * @param obj
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getShiftSelectedInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.empShift.getShiftSelectedInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}
	/**
	 * 已经排班人员信息
	 * 
	 * @param obj
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getSchedulingEmpInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.empShift.getSchedulingEmpInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}
	/**
	 * 已经排班人员信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getSchedulingEmpInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.empShift.getSchedulingEmpInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}
	@Override
	public int getSchedulingEmpInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.empShift.getSchedulingEmpInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnInt;
	}
	/**
	 * 已经排班人员信息
	 * 
	 * @param obj
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getEmpShiftDetailInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.empShift.getEmpShiftDetailInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}
	/**
	 * 已经排班人员信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getEmpShiftDetailInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.empShift.getEmpShiftDetailInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}
	@Override
	public int getEmpShiftDetailInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.empShift.getEmpShiftDetailInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnInt;
	}
}
