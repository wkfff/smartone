package com.siping.pa.service.salary;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface PaFormulaSer {
	
	
	public Object getPaFormulaObjectInfo(HttpServletRequest request) ;
	
	
	@SuppressWarnings("rawtypes")
	public List getPaFormulaInfo(HttpServletRequest request) ;
	
	public int getPaFormulaInfoCnt(HttpServletRequest request) ;
	
	
	@SuppressWarnings("rawtypes")
	public List getPaFormulaCnInfo(HttpServletRequest request) ;
	
	
	public String addPaFormulaInfo(HttpServletRequest request) ;
	
	
	public String updatePaFormulaInfo(HttpServletRequest request) ;
	
	
	public String deletePaFormulaInfo(HttpServletRequest request) ;
	
	
	public String initPaFormulaInfo(HttpServletRequest request) ;
}
