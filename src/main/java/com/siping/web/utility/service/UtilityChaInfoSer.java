package com.siping.web.utility.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface UtilityChaInfoSer {
	
	@SuppressWarnings({ "rawtypes" })
	public List getChannelList(HttpServletRequest request);
	
	public int getChannelListCnt(HttpServletRequest request);
	
}
