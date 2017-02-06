package com.siping.cust.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface CustAppendixSer {
	@SuppressWarnings("rawtypes")
	public List getAppendixList(HttpServletRequest request);
	public int getAppendixListCnt(HttpServletRequest request);
	public String removeAppendix(HttpServletRequest request);
}
