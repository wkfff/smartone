package com.siping.ess.dao;

import java.util.Date;
import java.util.Map;
  
public interface PasswordDao {
	
	public String updatePassword(Object obj)throws Exception;
	
	/**
	 * 根据username查询邮箱
	 * @param username
	 * @return 返回 null 表示不存在这个帐号
	 */
	public String getEmailByUsername(String username);
	
	/**
	 * 保存验证码专用
	 * @param object
	 * @return
	 */
	public boolean saveCheckCode(Map object);
	
	/**
	 * 验证验证码是否合格
	 * @param object
	 * @return
	 */
	public Date checkCkeckcode(Map object);

	public String updatepasswordAndCheckcode(Map object);
}
