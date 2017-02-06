package com.siping.ess.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.ess.dao.FuncToolsDao;
import com.siping.ess.service.FuncToolsSer;

@Service
public class FuncToolsSerImpl implements FuncToolsSer {

	@Autowired
	private FuncToolsDao funcToolsDao;
	@Override
	public List getChatterDeptTree() {
		Map aa = new HashMap();
		return funcToolsDao.getDeptTree(aa);
	}
	@Override
	public List getAllEmpDeptTree() {
		
		return funcToolsDao.getAllEmpDeptTree();
	}

}
