package com.siping.ess.dao;
 
import java.util.Map;
 

public interface EssAppCheckDao {
	/**
	 * 休假申请检查
	 * @param obj
	 * @return
	 */
	Map<Object,Object> leaveAppChecker(Object obj);
	/**
	 * 加班申请检查
	 * @param obj
	 * @return
	 */
	Map<Object,Object> otAppChecker(Object obj);
	/**
	 * 出差申请检查
	 * @param obj
	 * @return
	 */
	Map<Object,Object> btAppChecker(Object obj);
	/**
	 * 出差申请检查
	 * @param obj
	 * @return
	 */
	Map<Object,Object> cardAppChecker(Object obj);
	/**
	 * 费用申请检查
	 * @param obj
	 * @return
	 */
	Map<Object,Object> expAppChecker(Object obj);
	/**
	 * 信息申请检查
	 * @param obj
	 * @return
	 */
	Map<Object,Object> perAppChecker(Object obj);
	/**
	 * 信息申请检查
	 * @param obj
	 * @return
	 */
	Map<Object,Object> whAppChecker(Object obj);
	
	Map<Object, Object> toolAppChecker(Object obj);
	 
	
	
	
}
