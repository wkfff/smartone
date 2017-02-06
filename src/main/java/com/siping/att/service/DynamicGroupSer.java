package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface DynamicGroupSer {
   	
	public Object getDynamicGroup(HttpServletRequest request) ;
 
    @SuppressWarnings({ "rawtypes" })
	public List getDynamicGroupSelectionList(HttpServletRequest request) ;
    
    @SuppressWarnings({ "rawtypes" })
	public List getDynamicGroupList(HttpServletRequest request) ;
    
   	public int getDynamicGroupCnt(HttpServletRequest request) ;
	 
	public int addDynamicGroupInfo(HttpServletRequest request) ;
	 
	public int updateDynamicGroupInfo(HttpServletRequest request) ;
	 
	@SuppressWarnings({ "rawtypes" })
	public List getDeptList(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getDynamicGroupEmpInfo(HttpServletRequest request) ;
    
   	public int getDynamicGroupEmpInfoCnt(HttpServletRequest request) ;
	 
	public int addDynamicGroupEmpInfo(HttpServletRequest request) ;
	 
	public int deleteDynamicGroupInfo(HttpServletRequest request) ;

	public int deleteDynamicGroupEmpInfo(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getNonDynamicGroupEmpInfo(HttpServletRequest request) ;
    
   	public int getNonDynamicGroupEmpInfoCnt(HttpServletRequest request) ;
  
	 
}
