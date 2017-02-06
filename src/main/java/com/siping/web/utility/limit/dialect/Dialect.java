package com.siping.web.utility.limit.dialect;

public interface Dialect {
	
	public boolean supportsLimit();
	
	public String getLimitString(String sql,int offset,int limit);
	
}
