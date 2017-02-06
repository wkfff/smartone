package com.siping.fico.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.fico.dao.AccountDao;
import com.siping.fico.service.AccountSer;
import com.siping.web.utility.bean.ParamSearchBean;
import com.siping.web.utility.bean.ParamTransferListBean;

@Service
public class AccountSerImpl implements AccountSer {

	@Autowired
	private AccountDao accountDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getAccountList(HttpServletRequest request) {
		ParamSearchBean param = new ParamSearchBean(request);		
		try {
			return this.accountDao.getAccountList(param.getParamMap());
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}



	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map transferAccounts(HttpServletRequest request) {
		Map resultMap = new HashMap();
		resultMap.put("RESULT", "Y");
		ParamTransferListBean param = new ParamTransferListBean(request);
		param.generateList();		
		try{
			if(param.hasInsertList()){
				this.accountDao.addAccounts(param.getInsertList());
			}
			if(param.hasUpdateList()){
				this.accountDao.updateAccounts(param.getUpdateList());
			}
		}catch(SQLException e){
			resultMap.put("RESULT", "N");
			resultMap.put("REASON", "未知错误");
			e.printStackTrace();
		}
		return resultMap;
	}

}
