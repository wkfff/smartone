package com.siping.ess.service.impl;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.siping.ess.dao.ViewAppDao;
import com.siping.ess.dao.impl.ViewAppDaoImpl;
import com.siping.ess.service.ChangeAffirmSer;

@Service
public class ChangeAffirmSerImpl implements ChangeAffirmSer{
	
	Logger logger = Logger.getLogger(ChangeAffirmSerImpl.class.getName());
	private ViewAppDao viewAppDao = new ViewAppDaoImpl();
	
	
	public ViewAppDao getViewAppDao() {
		return viewAppDao;
	}

	public void setViewAppDao(ViewAppDao viewAppDao) {
		this.viewAppDao = viewAppDao;
	}

	@Override
	public String changeAffirm_flag_agree(String processInstanceId) {
		this.viewAppDao.updateLeaveAffirmflag_agree(processInstanceId);
		return "";
	}

	@Override
	public String changeAffirm_flag_veto(String processInstanceId) {
		this.viewAppDao.updateLeaveAffirmflag_veto(processInstanceId);
		return "";
	}
}
