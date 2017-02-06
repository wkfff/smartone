package com.siping.pa.dao.salary;

import java.util.List;

public interface PaFormulaDao {
	public Object getPaFormulaObjectInfo(Object object) ;
	
	@SuppressWarnings("rawtypes")
	public List getPaFormulaInfo(Object object) ;
	
	public int getPaFormulaInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaFormulaInfo(Object object, int currentPage, int pageSize);
	
	@SuppressWarnings("rawtypes")
	public List getFormulaItemInfo(Object obj) ;
	
	public String addPaFormulaInfo(Object obj) ;
	
	public String updatePaFormulaInfo(Object obj) ;
	
	public String deletePaFormulaInfo(Object obj) ;
	
	public String initPaFormulaInfo(Object obj) ;
}
