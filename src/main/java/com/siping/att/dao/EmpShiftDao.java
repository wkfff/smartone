package com.siping.att.dao;

import java.util.List;

public interface EmpShiftDao {

	@SuppressWarnings("rawtypes")
	public List getShift010();

	public int addEmpShift(Object object);
 
	public int getSchedulingEmpInfoCnt(Object object);
	 
	public int addShiftedInfo(Object object);
	 
	public int deleteShiftedInfo(Object object);
	 
	public int upShiftedInfo(Object object);
	 
	public int downShiftedInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getShiftSelectedInfo(Object object);
	 
	@SuppressWarnings("rawtypes")
	public List getSchedulingEmpInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getSchedulingEmpInfo(Object object, int currentPage, int pageSize);

	public int getEmpShiftDetailInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getEmpShiftDetailInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getEmpShiftDetailInfo(Object object, int currentPage, int pageSize);

}
