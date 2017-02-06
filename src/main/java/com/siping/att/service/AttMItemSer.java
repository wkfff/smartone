package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface AttMItemSer {
 
	public Object getAttMItemObjectInfo(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getAttMItemInfo(HttpServletRequest request) ;
	 
	public int getAttMItemInfoCnt(HttpServletRequest request) ;
	 
	public int addAttMItemInfo(HttpServletRequest request) ;
	 
	public int updateAttMItemInfo(HttpServletRequest request) ;
	 
	public int deleteAttMItemInfo(HttpServletRequest request) ;
	 
	public int checkDeleteAttMItemInfo(HttpServletRequest request) ;
	 
	public int updateAttMItemInfoCalOrder(HttpServletRequest request) ;
}
