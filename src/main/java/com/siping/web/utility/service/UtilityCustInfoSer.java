package com.siping.web.utility.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface UtilityCustInfoSer {

	@SuppressWarnings("rawtypes")
	List getCustomerList(HttpServletRequest request);

	int getCustomerListCnt(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
	List getAllCustomerList(HttpServletRequest request);

	int getAllCustomerListCnt(HttpServletRequest request);

}
