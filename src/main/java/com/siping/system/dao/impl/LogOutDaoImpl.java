package com.siping.system.dao.impl;

import java.sql.SQLException; 
import org.springframework.stereotype.Repository;

import com.siping.system.dao.LogOutDao; 
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class LogOutDaoImpl extends SqlMapClientSupport implements LogOutDao {
	/**
	 * 退出登录 修改信息
	 * (non-Javadoc)
	 * @see com.siping.system.dao.LogOutDao#updateLoginInfo(java.lang.Object)
	 */
	@Override
	public void updateLoginInfo(Object object) {
		try {
			this.update("system.login.updateLoginInfo", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} 
	}

}
