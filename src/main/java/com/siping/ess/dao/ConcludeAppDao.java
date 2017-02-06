package com.siping.ess.dao;

import java.util.List;

public interface ConcludeAppDao {
	
	@SuppressWarnings("rawtypes")
	public List getWhConclusionList(Object object);
	public int getWhConclusionListCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getAllEmpidList(Object object);
	@SuppressWarnings("rawtypes")
	public List getPersonHwConclusionList(Object object);
	
	@SuppressWarnings("rawtypes")
	public void addWhConclusion(List list);
}
