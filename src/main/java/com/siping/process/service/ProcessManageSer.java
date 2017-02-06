package com.siping.process.service;

import java.sql.SQLException;
import java.util.List; 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ProcessManageSer {

	/**
	 * 添加申请
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addObjectApp(HttpServletRequest request);
	@SuppressWarnings("rawtypes")
	public List getAffirmorList(HttpServletRequest request);
	@SuppressWarnings("rawtypes")
	public List getAffirmorResultList(HttpServletRequest request);
	
	@SuppressWarnings({ "rawtypes" }) 
	public Map getAffirmObjectInfo(HttpServletRequest request);
	@SuppressWarnings("rawtypes")
	public Map affirmApp(HttpServletRequest request);
	
	public String saveAndUpdateRejectStatus(HttpServletRequest request);
	
	
	/* ********************* Cmx idea****************************/
	
	
	
	
	
	
}
