package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface AttDetailCalulateSer {

	@SuppressWarnings({ "rawtypes" })
	public List getAttSupervisorList(HttpServletRequest request);

	public String detailCalculate(HttpServletRequest request);

}
