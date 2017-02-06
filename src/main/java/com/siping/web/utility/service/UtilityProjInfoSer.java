package com.siping.web.utility.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

public interface UtilityProjInfoSer {

	@SuppressWarnings("rawtypes")
	List getProjectProcessList(HttpServletRequest request);

	int getProjectProcessListCnt(HttpServletRequest request);
	
}
