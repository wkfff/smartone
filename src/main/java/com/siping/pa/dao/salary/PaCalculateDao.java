package com.siping.pa.dao.salary;

import java.sql.SQLException;
import java.util.LinkedHashMap; 
import java.util.List;
import java.util.Map;


public interface PaCalculateDao {

	
	@SuppressWarnings("rawtypes")
	public String paCalculate(LinkedHashMap object) ;

	public List getPaMonInfo(LinkedHashMap object);

	public List getPaSqlColumns(Object object);

	public void updatePaMonthInfo(Object object) throws SQLException;

	public int getPaMonInfoCnt(LinkedHashMap paramMap); 
}
