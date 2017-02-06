package com.siping.hrm.dao;

import java.util.List;

public interface HrmDao {
	public Object getDeptById(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getDeptTree(String sm, Object object);
	
	
	@SuppressWarnings({ "rawtypes" })
	public List getAllConPer(String sm);
}
