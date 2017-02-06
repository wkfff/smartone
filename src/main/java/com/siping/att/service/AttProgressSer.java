package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface AttProgressSer {
	@SuppressWarnings({ "rawtypes" })
	public List getAttProgressInfo(HttpServletRequest request);

	public int updateAttProgressInfo(HttpServletRequest request);

}
