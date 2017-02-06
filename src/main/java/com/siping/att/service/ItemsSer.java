package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface ItemsSer {
 
	public Object getItemObjectInfo(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getItemInfo(HttpServletRequest request) ;
    
	public int getItemInfoCnt(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getItemInfoSelection(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getAppTypeSelectionList(HttpServletRequest request) ;
    
    @SuppressWarnings({ "rawtypes" })
	public List getItemInfoTree(HttpServletRequest request) ;
	 
	public int addItemInfo(HttpServletRequest request) ;
	 
	public int checkItemInfo(HttpServletRequest request) ;
	
	public int updateItemInfo(HttpServletRequest request) ;
	 
	public int deleteItemInfo(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getItemParameterInfoList(HttpServletRequest request) ;
	 
	public Object getItemParameterInfo(HttpServletRequest request) ;
	 
	public int addItemParameterInfo(HttpServletRequest request) ;
	 
	public int updateItemParameterInfo(HttpServletRequest request) ;
	 
	public int deleteItemParameterInfo(HttpServletRequest request) ;
}
