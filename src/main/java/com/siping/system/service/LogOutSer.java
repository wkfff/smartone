package com.siping.system.service;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface LogOutSer {
	/**
	 * 退出登录 修改信息
	 * @param request
	 * @param response
	 */
	public void updateUserInfo(HttpServletRequest request,HttpServletResponse response);
}
