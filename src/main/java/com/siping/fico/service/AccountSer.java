package com.siping.fico.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface AccountSer {

	@SuppressWarnings({ "rawtypes" })
	public List getAccountList(HttpServletRequest request);	
	
	@SuppressWarnings("rawtypes")
	public Map transferAccounts(HttpServletRequest request);

}
