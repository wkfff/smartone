package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface AttDetailSer {

	@SuppressWarnings({ "rawtypes" })
	public List getAttDetailList(HttpServletRequest request);

	public int getAttDetailListCnt(HttpServletRequest request);

	public String getStartDateStr(HttpServletRequest request);

	public String getEndDateStr(HttpServletRequest request);
	
	public String getStartDateStr(HttpServletRequest request, String format);

	public String getEndDateStr(HttpServletRequest request, String format);

	public String updateAttDetailInfo(HttpServletRequest request); 
	
	public String deleteAttDetailInfo(HttpServletRequest request);

	public String addAttDetailInfo(HttpServletRequest request); 
}
