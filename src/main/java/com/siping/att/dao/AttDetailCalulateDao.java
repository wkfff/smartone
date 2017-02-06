package com.siping.att.dao;

import java.util.LinkedHashMap;
import java.util.List;  
public interface AttDetailCalulateDao {
	 @SuppressWarnings("rawtypes")
	 public  List getAttSupervisorList(Object object);
	 @SuppressWarnings("rawtypes")
     public String detailCalculate(LinkedHashMap object) ;

}
