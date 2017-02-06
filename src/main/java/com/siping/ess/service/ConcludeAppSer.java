package com.siping.ess.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface ConcludeAppSer {
	@SuppressWarnings("rawtypes")
	public List getWhConclusionList(HttpServletRequest request);
	public int getWhConclusionListCnt(HttpServletRequest request);
	
	public void calculateWhConclusion(HttpServletRequest request)throws SQLException;

}
