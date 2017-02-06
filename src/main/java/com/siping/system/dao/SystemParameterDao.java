package com.siping.system.dao;

import java.util.List;  

public interface SystemParameterDao {
	

	@SuppressWarnings({ "rawtypes" })
	public List getModuleParameterInfo(Object object) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getModuleParameterInfo(Object object,int currentPage, int pageSize);
	
	public int getModuleParameterInfoCnt(Object object) ;
  
	public int addModuleParameterInfo(Object object) ;

	@SuppressWarnings("rawtypes")
	public int addModuleParameterInfo(List objList) ;
	
	public int updateModuleParameterInfo(Object object) ;
	
	@SuppressWarnings("rawtypes")
	public int updateModuleParameterInfo(List objList) ;
	 
	public String deleteModuleParameterInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public String deleteModuleParameterInfo(List objList) ;
	


	@SuppressWarnings({ "rawtypes" })
	public List getLeaveAppParameterInfo(Object object) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getLeaveAppParameterInfo(Object object,int currentPage, int pageSize);
	
	public int getLeaveAppParameterInfoCnt(Object object) ;
  
	public int addLeaveAppParameterInfo(Object object) ;

	@SuppressWarnings("rawtypes")
	public int addLeaveAppParameterInfo(List objList) ;
	
	public int updateLeaveAppParameterInfo(Object object) ;
	
	@SuppressWarnings("rawtypes")
	public int updateLeaveAppParameterInfo(List objList) ;
	 
	public String deleteLeaveAppParameterInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public String deleteLeaveAppParameterInfo(List objList) ;

	
	@SuppressWarnings({ "rawtypes" })
	public List getOTAppParameterInfo(Object object) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getOTAppParameterInfo(Object object,int currentPage, int pageSize);
	
	public int getOTAppParameterInfoCnt(Object object) ;
  
	public int addOTAppParameterInfo(Object object) ;

	@SuppressWarnings("rawtypes")
	public int addOTAppParameterInfo(List objList) ;
	
	public int updateOTAppParameterInfo(Object object) ;
	
	@SuppressWarnings("rawtypes")
	public int updateOTAppParameterInfo(List objList) ;
	 
	public String deleteOTAppParameterInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public String deleteOTAppParameterInfo(List objList) ;
	@SuppressWarnings({ "rawtypes" })
	public List getSliceTypeParameter(Object object) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getSliceTypeParameter(Object object,int currentPage, int pageSize);
	
	public int getSliceTypeParameterCnt(Object object) ;
	@SuppressWarnings({ "rawtypes" })
	public List getSliceTypeDetail(Object object) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getSliceTypeDetail(Object object,int currentPage, int pageSize);
	
	public int getSliceTypeDetailCnt(Object object) ;
	@SuppressWarnings("rawtypes")
	public int addSliceTypeParameter(List objList) ;
	
	public int updateSliceTypeParameter(Object object) ;
	
	@SuppressWarnings("rawtypes")
	public int updateSliceTypeParameter(List objList) ;
	public String deleteSliceTypeParameter(Object object);
	@SuppressWarnings("rawtypes")
	public int deleteSliceTypeParameter(List objList) ;
	@SuppressWarnings("rawtypes")
	public int addSliceTypeDetail(List objList) ;
	
	@SuppressWarnings("rawtypes")
	public int updateSliceTypeDetail(List objList) ;
	public String deleteSliceTypeDetail(Object object);
	@SuppressWarnings("rawtypes")
	public String deleteSliceTypeDetail(List objList) ;
}
