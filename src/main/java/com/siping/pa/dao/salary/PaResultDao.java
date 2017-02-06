package com.siping.pa.dao.salary;

import java.util.LinkedHashMap;
import java.util.List;

public interface PaResultDao {
 
	@SuppressWarnings("rawtypes")
	public String paBalance(LinkedHashMap paramMap);

	@SuppressWarnings("rawtypes")
	public List getPaColumns(Object object);
}
