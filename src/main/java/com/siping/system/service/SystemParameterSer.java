package com.siping.system.service;

import java.util.List; 

import javax.servlet.http.HttpServletRequest;

public interface SystemParameterSer {

	@SuppressWarnings({ "rawtypes" })
	public List getModuleParameterInfo(HttpServletRequest request);
	   
	public int getModuleParameterInfoCnt(HttpServletRequest request);
	   
	public int addModuleParameterInfo(HttpServletRequest request);

	public int updateModuleParameterInfo(HttpServletRequest request);
	public String saveAmdUpdateModuleParameterInfo(HttpServletRequest request);
	public String deleteModuleParameterInfo(HttpServletRequest request);
	
	

	@SuppressWarnings({ "rawtypes" })
	public List getLeaveAppParameterInfo(HttpServletRequest request);
	   
	public int getLeaveAppParameterInfoCnt(HttpServletRequest request);
	   
	public int addLeaveAppParameterInfo(HttpServletRequest request);

	public int updateLeaveAppParameterInfo(HttpServletRequest request);
	public String saveAndUpdateLeaveAppParameterInfo(HttpServletRequest request);
	public String deleteLeaveAppParameterInfo(HttpServletRequest request);
	
	

	@SuppressWarnings({ "rawtypes" })
	public List getOTAppParameterInfo(HttpServletRequest request);
	   
	public int getOTAppParameterInfoCnt(HttpServletRequest request);
	   
	public int addOTAppParameterInfo(HttpServletRequest request);

	public int updateOTAppParameterInfo(HttpServletRequest request);
	public String saveAndUpdateOTAppParameterInfo(HttpServletRequest request);
	public String deleteOTAppParameterInfo(HttpServletRequest request);
	@SuppressWarnings({ "rawtypes" })
	public List getSliceTypeParameter(HttpServletRequest request);
	   
	public int getSliceTypeParameterCnt(HttpServletRequest request);
	@SuppressWarnings({ "rawtypes" })
	public List getSliceTypeDetail(HttpServletRequest request);
	   
	public int getSliceTypeDetailCnt(HttpServletRequest request);
	public int addSliceTypeParameter(HttpServletRequest request);

	public int updateSliceTypeParameter(HttpServletRequest request);
	public String saveAndUpdateSliceParameter(HttpServletRequest request);
	public String deleteSliceTypeParameter(HttpServletRequest request);
	public int addSliceTypeDetail(HttpServletRequest request);

	public int updateSliceTypeDetail(HttpServletRequest request);
	public String saveAndUpdateSliceTypeDetail(HttpServletRequest request);
	public String deleteSliceTypeDetail(HttpServletRequest request);
}
