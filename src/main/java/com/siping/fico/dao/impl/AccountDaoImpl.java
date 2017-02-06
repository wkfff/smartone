package com.siping.fico.dao.impl;

import java.sql.SQLException;
import java.util.List;
import org.springframework.stereotype.Repository;

import com.siping.fico.dao.AccountDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AccountDaoImpl extends SqlMapClientSupport implements AccountDao {

	@SuppressWarnings("rawtypes")
	@Override
	public List getAccountList(Object object) throws SQLException {
		return this.queryForList("fico.account.getAccountList", object);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void addAccounts(List list) throws SQLException {
		this.insertForList("fico.account.addAccount", list);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updateAccounts(List list) throws SQLException {
		this.updateForList("fico.account.updateAccount", list);
	}

}
