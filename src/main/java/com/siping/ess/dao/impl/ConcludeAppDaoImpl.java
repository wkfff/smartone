package com.siping.ess.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.ess.dao.ConcludeAppDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ConcludeAppDaoImpl extends SqlMapClientSupport implements ConcludeAppDao{

	@SuppressWarnings("rawtypes")
	@Override
	public List getWhConclusionList(Object object) {
		List resultList = new ArrayList();
		try {
			resultList = this.queryForList("ess.concludeApp.getWhConclusionList", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultList;
	}

	@Override
	public int getWhConclusionListCnt(Object object) {
		int resultNum = 0;
		try {
			resultNum = (Integer) this.queryForObject("ess.concludeApp.getWhConclusionListCnt", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultNum;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAllEmpidList(Object object) {
		List resultList = new ArrayList();
		try {
			resultList = this.queryForList("ess.concludeApp.getAllEmpidList", object);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return resultList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getPersonHwConclusionList(Object object) {
		List resultList = new ArrayList();
		try {
			resultList = this.queryForList("ess.concludeApp.getPersonHwConclusionList", object);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return resultList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void addWhConclusion(List list) {
		try {
			this.insertForList("ess.concludeApp.addWhConclusion", list);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
	}
}
