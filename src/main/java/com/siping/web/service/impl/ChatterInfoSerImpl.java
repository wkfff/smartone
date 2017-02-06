package com.siping.web.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.web.dao.ChatterInfoDao;
import com.siping.web.service.ChatterInfoSer;

@Service
public class ChatterInfoSerImpl implements ChatterInfoSer {

	@Autowired
	private ChatterInfoDao chatterInfoDao;
	@Override
	public List getChatterDeptTree() {
		Map aa = new HashMap();
		return chatterInfoDao.getDeptTree(aa);
	}
	@Override
	public List getAllEmpDeptTree() {
		
		return chatterInfoDao.getAllEmpDeptTree();
	}

}
