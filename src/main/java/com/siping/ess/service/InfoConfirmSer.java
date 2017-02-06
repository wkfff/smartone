package com.siping.ess.service;
 

import javax.servlet.http.HttpServletRequest;
  
public interface InfoConfirmSer { 

	/**
	 * 信息确认
	 * @param request
	 */
	public String confirmApp(HttpServletRequest request);


	/**
	 * 信息删除
	 * @param request
	 */
	public String delApp(HttpServletRequest request);
}
