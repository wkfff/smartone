package com.siping.ess.dao;

import java.util.List;
  
public interface InfoConfirmDao { 
	/**
	 * 信息确认
	 * @param objectList
	 * @return 
	 */  
	@SuppressWarnings("rawtypes")
	public String confirmPerInfo(List objectList);
	/**
	 * 信息确认
	 * @param objectList
	 * @return 
	 */  
	@SuppressWarnings("rawtypes")
	public String confirmWhInfo(List objectList);
	/**
	 * 信息确认
	 * @param objectList
	 * @return 
	 */  
	@SuppressWarnings("rawtypes")
	public String confirmOtInfo(List objectList); 
	/**
	 * 信息确认
	 * @param objectList
	 * @return 
	 */  
	@SuppressWarnings("rawtypes")
	public String confirmLeaveInfo(List objectList); 
	/**
	 * 信息确认
	 * @param objectList
	 * @return 
	 */  
	@SuppressWarnings("rawtypes")
	public String confirmBizInfo(List objectList); 
	/**
	 * 信息确认
	 * @param objectList
	 * @return 
	 */  
	@SuppressWarnings("rawtypes")
	public String confirmExpInfo(List objectList); 
	/**
	 * 信息确认
	 * @param objectList
	 * @return 
	 */  
	@SuppressWarnings("rawtypes")
	public String confirmCardtimeInfo(List objectList); 
	
	@SuppressWarnings("rawtypes")
	public String delPersonInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String delOtInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String delLeaveInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String delBTInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String delTrainingInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String delExpInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String delWhInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String delCardtimeInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String confirmToolInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String delToolInfo(List objectList);
}
