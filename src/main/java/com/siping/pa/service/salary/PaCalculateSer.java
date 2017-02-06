package com.siping.pa.service.salary;
  
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface PaCalculateSer {
	
	public String paCalculate(HttpServletRequest request) ;

	@SuppressWarnings("rawtypes")
	public List getPaMonInfo(HttpServletRequest request);

	public String updatePaMonthInfo(HttpServletRequest request);

	public int getPaMonInfoCnt(HttpServletRequest request);
}
